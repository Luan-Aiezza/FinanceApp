//
//  GoalCardView.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 28/10/24.
//



import SwiftUI

struct GoalCardView: View {
    var goalName: String
    var goalAmount: Float = 0
    var savedAmount: Float
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            //Nome da Meta e Ícone
            HStack {
                Text(goalName)
                    .font(
                        Font.custom("Pally-Bold", size: 22)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                Spacer()
                Text("Price: \(String(format: "%.1f", goalAmount)) coincs")
                    .font(
                        Font.custom("Pally-Bold", size: 22)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
            }
            
            
            // Status de Moedas Necessárias
            HStack {
                Image("CoinsImage")
                //Text("You need \(String(format: "%.2f", goalAmount)) coincs")
                //  .font(.subheadline)
                // .foregroundColor(.cardTextTP)
            }
            Spacer()
            
            HStack {
                Spacer()
                Text("\(String(format: "%.0f", (savedAmount / goalAmount) * 100))% Progress")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
            }
            
            
            // Barra de Progresso
            ProgressView(value: savedAmount, total: goalAmount)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
            
            // Progresso e Quantia Salva
            HStack {
                if savedAmount >= goalAmount {
                    Image(systemName: "CheckMARK")
                    Text("Congratulations! Goal achieved!")
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                } else {
                    Image("CheckMARK")
                    Text("You have saved \(String(format: "%.1f", savedAmount)) coincs by now")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                    
                    Spacer()
                    if savedAmount < goalAmount {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("You still need \(String(format: "%.1f", goalAmount - savedAmount)) coincs to complete")
                                .font(
                                    Font.custom("Pally-Regular", size: 17)
                                        .weight(.medium)
                                )
                                .foregroundColor(.cardTextTP)
                        }
                    }
                }
                
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .clipShape(.rect(cornerRadius: 24.0))
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.85, green: 0.76, blue: 0.89))
                .offset(x:0, y: 6)
        )
    }
}


