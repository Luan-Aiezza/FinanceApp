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
                    .foregroundColor(.cardTextTP)
                
                Spacer()
                Text("Price \(String(format: "%.2f", goalAmount)) coincs")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.cardTextTP)
            }
            
            // Status de Moedas Necessárias
            HStack {
                Image("CoinsImage")
                Text("You need \(String(format: "%.2f", goalAmount)) coincs")
                    .font(.subheadline)
                    .foregroundColor(.cardTextTP)
            }
            Spacer()
            
            HStack {
                Spacer()
                Text("\(Int((savedAmount / goalAmount) * 100))% Progress")
                    .font(.subheadline)
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
                        .font(.subheadline)
                        .foregroundColor(.cardTextTP)
                } else {
                    Image("CheckMARK")
                    Text("You have saved \(String(format: "%.2f", savedAmount)) coincs by now")
                        .font(.subheadline)
                        .foregroundColor(.cardTextTP)
                    
                    Spacer()
                    if savedAmount < goalAmount {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("You still need \(String(format: "%.2f", goalAmount - savedAmount)) coincs to complete")
                                .font(.subheadline)
                                .foregroundColor(.cardTextTP)
                        }
                    }
                }
                
            }
            
            // Quantia Restante
            
        }
        .padding()
        .background(Color(.backgroundLightPurple))
        .cornerRadius(12)
        .shadow(radius: 4)
        .frame( height: 211)
    }
}



