//
//  TestNewPiggyBankModal.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//
import SwiftUI

struct TestNewPiggyBankModal: View {
    @Binding var isPresented: Bool
    var goalToEdit: GoalBankModel?
    @State private var goalName = ""
    @State private var goalAmount = ""
    
    @State var addGoal: (_ name: String, _ amount: Int) -> Void
    
   
    private var isGoalAmountValid: Bool {
        if let amount = Int(goalAmount), amount > 0 {
            return true
        }
        return false
    }
    
    init(isPresented: Binding<Bool>, goalToEdit: GoalBankModel? = nil, addGoal: @escaping (_ name: String, _ amount: Int) -> Void) {
        self.addGoal = addGoal
        self._isPresented = isPresented
        self.goalToEdit = goalToEdit
        _goalName = State(initialValue: goalToEdit?.cashBox.cashBoxDescription ?? "")
        _goalAmount = State(initialValue: "\(goalToEdit?.goalAmount ?? 0)")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .font(Font.custom("Pally-Bold", size: 17))
                .foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text(goalToEdit == nil ? "New Piggy Bank" : "Edit Piggy Bank")
                    .foregroundColor(.primary)
                    .font(Font.custom("Pally-Bold", size: 17))
                
                Spacer()
                
                Button("Done") {
                    if let amount = Int(goalAmount) {
                        addGoal(goalName, amount)
                        isPresented = false
                    }
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                .foregroundColor(.mediumPurple)
                .disabled(!isGoalAmountValid) // Desativa o botão se o valor for inválido
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("What do you want to buy?")
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                    .foregroundColor(Color.black.opacity(0.7))
                
                TextField("Enter item", text: $goalName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                Text("How much does it cost?")
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                    .foregroundColor(Color.black.opacity(0.7))
                
                TextField("0", text: $goalAmount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(isGoalAmountValid ? Color.gray.opacity(0.5) : Color.red)) // Mostra vermelho se inválido
                
                if !isGoalAmountValid && !goalAmount.isEmpty {
                    Text("Please enter a valid amount greater than 0.")
                        .font(Font.custom("Pally-Regular", size: 14))
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .cornerRadius(20)
        .frame(width: 500, height: 300)
    }
}
