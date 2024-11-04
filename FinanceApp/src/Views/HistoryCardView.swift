//
//  GoalCardView.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 28/10/24.
//



import SwiftUI

struct HistoryCardView: View {
    var mounthData: Data
    var taskState: Bool
    var countTasks: Int = 0
    var goalsInProgress: Int = 0
    var totalCoins: Double
    var piggyCoinsTrans: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Data do mes e ano em que da tarefa (mounthData)
            Text("Data do mes e ano")
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            // Verificar se a tarefa foi concluida (taskState)
            Text("Task's done")
                .font(.subheadline)
            Spacer()
            HStack{
                //simbolo de que a task está completa
                Image(systemName: taskState ? "checkmark.circle.fill" : "circle")
                    .padding()
                //Contar quantas tasks foram feitas naquele mes (countTasks)
                Text("\(countTasks)")
                Spacer()
                //(totalCoins)
                Image("blackIconCoin")
                VStack{
                    Text("\(totalCoins)")
                    Text("Total")
                }
            }
            Spacer()
            Text("Active Piggy bank")
            HStack{
                Image(systemName: "Person.fill")
                //(goalsInProgress)
                Text("\(goalsInProgress)")
            }
            HStack{
                Image("blackIconCoin")
                //quntas moedas foram transferidas para a meta (piggyCoinsTrans)
                Text("\(piggyCoinsTrans)")
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(24)
    }
}



