//
//  TestNewPiggyBankModal.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI
struct TestNewPiggyBankModal: View {
    @Binding var isPresented: Bool
//    @ObservedObject var viewModel: TestCashBoxViewModel
    var goalToEdit: GoalBankModel? // `goalToEdit` agora é opcional
    @State private var goalName = ""
    @State private var goalAmount = ""
    
    @State var addGoal: (_ name: String, _ amount: Int) -> Void
    
    init(isPresented: Binding<Bool>, goalToEdit: GoalBankModel? = nil, addGoal: @escaping (_ name: String, _ amount: Int) -> Void) {
        self.addGoal = addGoal
        self._isPresented = isPresented
//        self.viewModel = viewModel
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
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text(goalToEdit == nil ? "New Piggy Bank" : "Edit Piggy Bank")
                    .foregroundColor(.primary)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                Spacer()
                
                Button("Done") {
                    if let amount = Int(goalAmount) {
//                        if let goal = goalToEdit {
//                            viewModel.updateGoal(goal: goal, name: goalName, amount: amount)
//                        } else {
//                            viewModel.addGoal(name: goalName, amount: amount)
//                        }
                        addGoal(goalName, amount)
                        isPresented = false
                    }
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(.mediumPurple)
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("What do you want to buy?")
                    .font(Font.custom("Pally-Bold", size: 17)
                        .weight(.medium))
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
                
                TextField("50,00", text: $goalAmount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }
            .padding(.horizontal)
            
            Spacer()
        }
//        .background(Color(red: 22, green: 22, blue: 22))
        .padding()
        .cornerRadius(20)
        .frame(width: 500, height: 300)
    }
    
}
