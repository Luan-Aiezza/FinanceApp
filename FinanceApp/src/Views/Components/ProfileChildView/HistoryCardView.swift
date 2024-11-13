import SwiftUI

struct HistoryCardView: View {
    
    // Obtenha a data atual
    private let currentDate = Date()
    
    // Crie um formatador para exibir o mês e ano
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // Formato para mês e ano (ex.: "novembro 2024")
        return formatter
    }
    
    var mounthData: Data
    var taskState: Bool
    var countTasks: Int = 0
    var goalsInProgress: Int = 0
    var totalCoins: Int
    var piggyCoinsTrans: Int

    var body: some View {
        VStack(alignment: .leading) {
            // Data do mes e ano em que da tarefa (mounthData)
            Text(monthYearFormatter.string(from: currentDate))
                .font(
                    Font.custom("Pally-Bold", size: 24)
                        .weight(.medium)
                )
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                .fontWeight(.bold)
                .scaledToFill()
            
            // Verificar se a tarefa foi concluida (taskState)
            Text("Task's done")
                .font(
                    Font.custom("Pally-Bold", size: 22)
                        .weight(.medium)
                )
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                .scaledToFill()

            HStack{
                //simbolo de que a task está completa
                Image(systemName: taskState ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .padding()
                    .scaledToFill()
                //Contar quantas tasks foram feitas naquele mes (countTasks)
                Text("\(countTasks) tasks done sucessfully")
                    .font(
                        Font.custom("Pally-Regular", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .scaledToFill()
                Spacer()
                //(totalCoins)
                Image("blackIconCoin")
                    .scaledToFill()
                VStack{
                    Text("\(totalCoins)")
                        .font(
                            Font.custom("Pally-Regular", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                        .scaledToFill()
                    Text("Total")
                        .font(
                            Font.custom("Pally-Regular", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                        .scaledToFill()
                }.padding(.horizontal, 32)
            }
            Text("Active Piggy bank")
                .font(
                    Font.custom("Pally-Bold", size: 22)
                        .weight(.medium)
                )
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                .scaledToFill()
            HStack{
                Image("PiggyIcon")
                    .scaledToFill()
                //(goalsInProgress)
                Text("\(goalsInProgress) piggy bank in progress!")
                    .font(
                        Font.custom("Pally-Regular", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .scaledToFill()
            }
            HStack{
                Image("blackIconCoin")
                    .scaledToFill()

                //quntas moedas foram transferidas para a meta (piggyCoinsTrans)
                Text("\(Int(piggyCoinsTrans)) coins have been transferred to the piggy!")
                    .font(
                        Font.custom("Pally-Regular", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .scaledToFill()
                   
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
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



