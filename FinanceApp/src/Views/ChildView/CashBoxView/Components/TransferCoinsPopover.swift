//
//  TransferCoinsPopover.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI

struct TransferCoinsPopover: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var transferAmount = ""
    @State private var selectedGoal: UUID?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text("Transfer Coins")
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("Done") {
                    if let goalID = selectedGoal, let amount = Int(transferAmount) {
                        viewModel.addCoinsToGoal(goalID: goalID, amount: amount)
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple)
                .disabled(selectedGoal == nil || transferAmount.isEmpty || Int(transferAmount) ?? 0 <= 0)
            }
            .padding([.horizontal])
            .padding(.top, 40)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("How many coins do you want to transfer?")
                    .font(.headline)
                
                HStack {
                    TextField("Enter amount", text: $transferAmount)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                }
                
                Text("Transfer to which piggy bank?")
                    .font(.headline)
                
                TestPickerCash(selectedGoal: $selectedGoal, viewModel: viewModel)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 300)
        .cornerRadius(20)
    }
}
