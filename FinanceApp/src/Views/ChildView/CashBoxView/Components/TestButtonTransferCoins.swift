//
//  TestButtonTransferCoins.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//
import SwiftUI
struct TestButtonTransferCoins: View {
    @Binding var showTransferCoinsPopover: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    
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
//            .padding()
//            .background(viewModel.goalBanks.isEmpty ? Color.gray : Color.white)
//            .cornerRadius(20)
//            .frame(width: 200, height: 40)
//            .shadow(color: viewModel.goalBanks.isEmpty ? Color.clear : Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
            }
        .disabled(viewModel.goalBanks.isEmpty) // Desativa o botão se não houver metas
        .popover(isPresented: $showTransferCoinsPopover) {
            TransferCoinsPopover(isPresented: $showTransferCoinsPopover, viewModel: viewModel)
                .frame(width: 500, height: 300)
                .background(Color.white)// Define a cor de fundo do popover
                .preferredColorScheme(.light) // Força o modo claro
        }
        .padding(.trailing)
    }
}
