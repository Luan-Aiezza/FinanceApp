import SwiftUI
import SwiftData

struct SelectedChild: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var historyViewModel: HistoryViewModel
    @ObservedObject var parentViewModel: ParentViewModel
    
    init(parentViewModel: ParentViewModel) {
        self.historyViewModel = .init(id: parentViewModel.firstChildId ?? UUID())
        self.parentViewModel = parentViewModel
        
    }
    
    @State private var currentChild: UUID?
    @State private var selectedChild: ChildModel?
    
    let gridItem = [GridItem(.adaptive(minimum: 200))]
    
    
    var body: some View {
        
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack(alignment: .center, spacing: 20){
                    //Scroll horizontal das crianças
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItem){
                            HStack(spacing: 40){
                                ForEach(parentViewModel.childdren!){ child in
                                    VStack(){
                                        Button(action: {
                                            historyViewModel.id = child.id
                                            historyViewModel.fetch()
                                        }){
                                            VStack{
                                                Image("iconChildGrid")
                                                    .scaledToFit()
                                                    .foregroundColor(.cyan)
                                                    .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                                                    .background(
                                                        Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                                            .offset(x:0, y: 6)// Borda branca opcional para destaque
                                                    )
                                                Text("\(child.name)")
                                                    .font(
                                                        Font.custom("Pally-Bold", size: 24)
                                                            .weight(.medium)
                                                    )
                                                    .foregroundColor(.white)
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width / 2)
                        //.position(y: UIScreen.main.bounds.height / 2)
                    }
                    .frame(width: UIScreen.main.bounds.width / 2)
                    HistoryCardView(
                        mounthData: Data(),
                        taskState: Bool(true),
                        //tasksDoneInCurrentMonth
                        countTasks: historyViewModel.tasksDoneInCurrentMonth,
                        //activePiggyBank
                        goalsInProgress: historyViewModel.activePiggyBank,
                        //valueOfTasksDoneInCurrentMonth
                        totalCoins: Int(historyViewModel.valueOfTasksDoneInCurrentMonth),
                        //coinsInPiggyBank
                        piggyCoinsTrans: Int(historyViewModel.coinsInPiggyBank)
                    )
                    
                    //Card da criança
                    //                    HistoryCardView(
                    //                        mounthData: Data(),
                    //                        taskState: Bool(true),
                    //                        countTasks: Int(40),
                    //                        goalsInProgress: Int(10),
                    //                        totalCoins: Int(100),
                    //                        piggyCoinsTrans: Int(20)
                    //                    )
                    //TITULO TASK
                    Text("Tasks")
                        .font(
                            Font.custom("Pally-Bold", size: 28)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    TaskCreateCard(dayCount: 1)
                        .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                    Spacer()
                    //TASKS FEITAS
                    
                    
                }.padding(.horizontal, 85)
                    .onAppear{
                        historyViewModel.modelContext = modelContext
                        historyViewModel.fetch()
                    }
            }
        }
    }
}
