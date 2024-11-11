//
//  TestNewPiggyBankModal.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI

struct TestNewPiggyBankModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    var goalToEdit: GoalBankModel?
    @State private var goalName = ""
    @State private var goalAmount = ""
    
    init(isPresented: Binding<Bool>, viewModel: CashBoxViewModel, goalToEdit: GoalBankModel? = nil) {
        self._isPresented = isPresented
        self.viewModel = viewModel
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
                .foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text(goalToEdit == nil ? "New Piggy Bank" : "Edit Piggy Bank")
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("Done") {
                    if let amount = Int(goalAmount) {
                        if let goal = goalToEdit {
                            viewModel.updateGoal(goal: goal, name: goalName, amount: amount)
                        } else {
                            viewModel.addGoal(name: goalName, amount: amount)
                        }
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple)
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("What do you want to buy?")
                    .font(.headline)
                
                TextField("Enter item", text: $goalName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                Text("How much does it cost?")
                    .font(.headline)
                
                TextField("50,00", text: $goalAmount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .cornerRadius(20)
        .frame(width: 500, height: 300)
    }
}
