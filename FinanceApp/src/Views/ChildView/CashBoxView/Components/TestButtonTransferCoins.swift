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
                Text("Transfer Coins")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
            }
        }
        .disabled(viewModel.goalBanks.isEmpty)
        .popover(isPresented: $showTransferCoinsPopover) {
            TransferCoinsPopover(isPresented: $showTransferCoinsPopover, viewModel: viewModel)
                .frame(width: 500, height: 300)
                .background(Color.white)
                .preferredColorScheme(.light)
        }
        .padding(.trailing)
    }
}

