//
//  CButton.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 28/10/24.
//

import SwiftUI

struct CButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        VStack{
            Button(action: {action()}) {
                HStack(alignment: .center, spacing: 8) { Text(text)
                        .font(
                          Font.custom("Pally Variable", size: 17)
                            .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                        .frame(maxWidth: .infinity, alignment: .center) }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                .background(Color(red: 0.99, green: 0.99, blue: 0.99))
                .cornerRadius(24)
                .offset(y: -4)
                .overlay(
                  RoundedRectangle(cornerRadius: 24)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.73, green: 0.57, blue: 0.8), lineWidth: 1)
                )
                .background(Color(red: 0.73, green: 0.57, blue: 0.8)) // Cor principal do botão
                    .cornerRadius(24)
            }
            .frame(maxWidth: .infinity)
            .shadow(color: Color(red: 0.73, green: 0.57, blue: 0.8).opacity(0.5), radius: 5, x: 0, y: 4) // Adiciona um efeito de sombra sutil
        }

    }
}

#Preview {
    CButton(text: "Teste", action: {print("Teste")})
}
