//
//  TransferCoinsPopover.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI
struct TransferCoinsPopover: View {
    @Binding var isPresented: Bool
    @State private var transferAmount = ""
    @State private var selectedGoal: UUID? = nil // Identificador para a meta selecionada
    @State var addCoinsToGoal: (_ goalID: UUID, _ amount: Int) -> Void
    @Binding var goals: [GoalBankModel]

    var body: some View {
        VStack(spacing: 20) {
            // Cabeçalho com os botões de Cancel e Done
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text("Transfer coincs")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("Done") {
                    if let goalID = selectedGoal, let amount = Int(transferAmount) {
                        addCoinsToGoal(goalID, amount)
                        isPresented = false
                    }
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(.mediumPurple)
                .disabled(selectedGoal == nil || transferAmount.isEmpty || Int(transferAmount) ?? 0 <= 0)
            }
            .padding([.horizontal])
            .padding(.top, 40) // Ajuste de espaçamento superior
            
            Divider() // Linha divisória abaixo do cabeçalho
            
            VStack(alignment: .leading, spacing: 16) {
                // Campo de entrada para o valor a ser transferido
                Text("How many coincs do you want to transfer?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    Image(systemName: "magnifyingglass") // Use um ícone padrão ou substitua conforme necessário
                        .foregroundColor(.gray)
                    
                    TextField("Enter amount", text: $transferAmount)
                        .keyboardType(.numberPad)
                        .padding(.leading, 8)
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                // Picker para selecionar a meta
                Text("Transfer to which piggy?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                TestPickerCash(selectedGoal: $selectedGoal, goals: goals)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 300)
        .cornerRadius(20)
    }
}
