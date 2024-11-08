import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: HistoryViewModel

    init(id: UUID){
        viewModel = HistoryViewModel(id: id)
    }
    //    @ObservedObject var viewModel = CashBoxViewModel()
    @ObservedObject var viewModel2 = ParentViewModel()
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack(spacing: 32){
                    //TITULO HISTORY
                    Text("Your history!")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .font(
                            Font.custom("Pally-Bold", size: 24)
                                .weight(.medium)
                        )
                        .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color(red: 0.36, green: 0, blue: 0.55))
                        .clipShape(.rect(cornerRadius: 24.0))
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color(red: 0.25, green: 0, blue: 0.39))
                                .offset(x:0, y: 6)
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
                                totalCoins: Int(viewModel.valueOfTasksDoneInCurrentMonth),
                                //coinsInPiggyBank
                                piggyCoinsTrans: Int(viewModel.coinsInPiggyBank)
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
