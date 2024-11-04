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
        VStack(alignment: .leading) {
            // Data do mes e ano em que da tarefa (mounthData)
            Text("Data do mes e ano")
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                .fontWeight(.bold)
            Spacer()
            // Verificar se a tarefa foi concluida (taskState)
            Text("Task's done")
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
            Spacer()
            HStack{
                //simbolo de que a task está completa
                Image(systemName: taskState ? "checkmark.circle.fill" : "circle")
                    .padding()
                //Contar quantas tasks foram feitas naquele mes (countTasks)
<<<<<<< HEAD:FinanceApp/src/Views/HistoryCardView.swift
                Text("\(countTasks)")
=======
                Text("Contador de quantas tasks foram feitas naquele mês")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
>>>>>>> MergePiggyBankDeveloper:FinanceApp/src/Views/Components/ProfileChildView/HistoryCardView.swift
                Spacer()
                //(totalCoins)
                Image("blackIconCoin")
                VStack{
<<<<<<< HEAD:FinanceApp/src/Views/HistoryCardView.swift
                    Text("\(totalCoins)")
=======
                    Text("Valor de moedas que aquela tarefa concebeu")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
>>>>>>> MergePiggyBankDeveloper:FinanceApp/src/Views/Components/ProfileChildView/HistoryCardView.swift
                    Text("Total")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
                }
            }
            Spacer()
            Text("Active Piggy bank")
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
            HStack{
                Image("blackIconCoin")
                //(goalsInProgress)
<<<<<<< HEAD:FinanceApp/src/Views/HistoryCardView.swift
                Text("\(goalsInProgress)")
=======
                Text("Quantas metas ela tem atualmente")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
>>>>>>> MergePiggyBankDeveloper:FinanceApp/src/Views/Components/ProfileChildView/HistoryCardView.swift
            }
            HStack{
                Image("blackIconCoin")
                //quntas moedas foram transferidas para a meta (piggyCoinsTrans)
<<<<<<< HEAD:FinanceApp/src/Views/HistoryCardView.swift
                Text("\(piggyCoinsTrans)")
=======
                Text("Total de moedas transferidas para o cofrinho")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
>>>>>>> MergePiggyBankDeveloper:FinanceApp/src/Views/Components/ProfileChildView/HistoryCardView.swift
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



