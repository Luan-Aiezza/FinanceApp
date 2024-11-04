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
    var totalCoins: Int
    var piggyCoinsTrans: Int

    var body: some View {
        VStack(alignment: .leading) {
            // Data do mes e ano em que da tarefa (mounthData)
            Text("November, 2024")
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                .fontWeight(.bold)
            Spacer()
            // Verificar se a tarefa foi concluida (taskState)
            Text("Task's done")
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            Spacer()
            HStack{
                //simbolo de que a task está completa
                Image(systemName: taskState ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .padding()
                //Contar quantas tasks foram feitas naquele mes (countTasks)
                Text("\(countTasks) tasks done sucessfully")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                Spacer()
                //(totalCoins)
                Image("blackIconCoin")
                VStack{
                    Text("\(totalCoins)")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    Text("Total")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                }
            }
            Spacer()
            Text("Active Piggy bank")
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            HStack{
                Image("blackIconCoin")
                //(goalsInProgress)
                Text("\(goalsInProgress) piggy bank in progress!")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            }
            HStack{
                Image("blackIconCoin")
                //quntas moedas foram transferidas para a meta (piggyCoinsTrans)
                Text("\(Int(piggyCoinsTrans)) coins have been transferred to the piggy!")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: 256, alignment: .leading)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(24)
        .clipShape(.rect(cornerRadius: 24.0))
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.85, green: 0.76, blue: 0.89))
                .offset(x:0, y: 6)
                )
    }
}



