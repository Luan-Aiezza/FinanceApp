//
//  Untitled.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI

struct TestButtonCreatePiggyBank: View {
    @Binding var showNewPiggyBankPopover: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    
    var body: some View {
        Button(action: {
            showNewPiggyBankPopover.toggle()
        }) {
            HStack {
                Image(systemName: "plus")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                Text("New Piggy Bank")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
            }
        }
        .popover(isPresented: $showNewPiggyBankPopover) {
            TestNewPiggyBankModal(
                isPresented: $showNewPiggyBankPopover,
                viewModel: viewModel
            )
            .frame(width: 500, height: 300)
            .background(Color.white)
            .preferredColorScheme(.light)
        }
    }
}
