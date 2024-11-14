//
//  TestButtonTransferCoins.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//
import SwiftUI
struct TestButtonTransferCoins: View {
    @Binding var showTransferCoinsPopover: Bool
    @Binding var goals: [GoalBankModel]
    @State var addCoinsToGoal: (_ goalID: UUID, _ amount: Int) -> Void
    
    var body: some View {
        Button(action: {
            showTransferCoinsPopover.toggle()
        }) {
            HStack {
                Image(systemName: "arrow.right.arrow.left")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                Text("Transfer Coincs")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
            }
        }
        .disabled(goals.isEmpty) // Desativa o botão se não houver metas
        .popover(isPresented: $showTransferCoinsPopover) {
            TransferCoinsPopover(isPresented: $showTransferCoinsPopover, addCoinsToGoal: addCoinsToGoal, goals: $goals)
                .frame(width: 500, height: 300)
                .background(Color.white)// Define a cor de fundo do popover
                .preferredColorScheme(.light) // Força o modo claro
        }
        .padding(.trailing)
    }
}
