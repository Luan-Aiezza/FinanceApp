//
//  GoalCardView.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 28/10/24.
//



import SwiftUI

struct GoalCardView: View {
    var goalName: String
    var goalAmount: Double
    var savedAmount: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Nome da Meta e Ícone
            HStack {
                Text(goalName)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                Text("Price \(String(format: "%.2f", goalAmount)) coincs")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            
            // Status de Moedas Necessárias
            HStack {
                Image("CoinsImage")
                Text("You need \(String(format: "%.2f", goalAmount)) coincs")
                    .font(.subheadline)
            }
            Spacer()
            
            HStack {
                Spacer()
                Text("\(Int((savedAmount / goalAmount) * 100))% Progress")
                    .font(.subheadline)
            }
           
            
            // Barra de Progresso
            ProgressView(value: savedAmount, total: goalAmount)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
            
            // Progresso e Quantia Salva
            HStack {
                if savedAmount >= goalAmount {
                    Image(systemName: "CheckMARK")
                    Text("Congratulations! Goal achieved!")
                        .font(.subheadline)
                } else {
                    Image("CheckMARK")
                    Text("You have saved \(String(format: "%.2f", savedAmount)) coincs by now")
                        .font(.subheadline)
                    
                    Spacer()
                    if savedAmount < goalAmount {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("You still need \(String(format: "%.2f", goalAmount - savedAmount)) coincs to complete")
                                .font(.subheadline)
                        }
                    }
                }
                
            }
            
            // Quantia Restante
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}



