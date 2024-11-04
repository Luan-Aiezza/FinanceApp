import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: HistoryViewModel

    init(id: UUID){
        viewModel = HistoryViewModel(id: id)
    }
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack(alignment: .leading, spacing: 20){
                    Spacer()
                    //TITULO HISTORY
                    Text("History")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .font(
                        Font.custom("Pally Variable", size: 24)
                        .weight(.medium)
                        )
                        .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color(red: 0.36, green: 0, blue: 0.55))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.36, green: 0, blue: 0.55), lineWidth: 1)
                        )
                    ScrollView {
                        VStack(spacing: 20) {
                            HistoryCardView(
                                mounthData: Data(),
                                taskState: Bool(true),
                                //tasksDoneInCurrentMonth
                                countTasks: viewModel.tasksDoneInCurrentMonth,
                                //activePiggyBank
                                goalsInProgress: viewModel.activePiggyBank,
                                //valueOfTasksDoneInCurrentMonth
                                totalCoins: Double(viewModel.valueOfTasksDoneInCurrentMonth),
                                //coinsInPiggyBank
                                piggyCoinsTrans: Double(viewModel.coinsInPiggyBank)
                            )
                        }
                    }
                    Spacer()

                }
            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.fetch()
        }
    }
}

//#Preview {
//    HistoryView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
