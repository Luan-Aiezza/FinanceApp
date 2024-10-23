//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI

struct ProfileChildTopBar: View {
    
    var body: some View {
        VStack {
            HStack {
                // Ícone da criança no canto superior esquerdo
                Button(action: {
                    // Ação do botão (ex: abrir perfil da criança)
                }) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
                .padding(.leading, 16)
                
                Spacer()
                
                // Toolbar com três opções (exemplo de ícones)
                HStack(spacing: 20) {
                    Button(action: {
                        // Ação 1
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        // Ação 2
                    }) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        // Ação 3
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                

                // Ícone da Cash Box (moeda) no canto superior direito
                NavigationLink(destination: CashBoxView()) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 16)
            // Calendário simples (indicando mês)
            Text("Outubro 2024")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
            
        }
    }
}

#Preview {
    ProfileChildTopBar()
}
