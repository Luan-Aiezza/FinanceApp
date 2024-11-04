import SwiftUI
import SwiftData

struct SelectedChild: View {
    
    
//    @Environment(\.modelContext) private var modelContext
//    let id: UUID
//    @State var child: ChildModel?
//    @Query private var childs: [ChildModel]
//    @ObservedObject var profileChildViewModel: ProfileChildViewModel
//    //    @State var view: some View = HistoryView()
//    init(id: UUID) {
//        self.id = id
//        profileChildViewModel = .init(id: id)
//    }
//    
//    
//    func getTasks() -> [TaskModel] {
//        if let child = childs.first(where: {$0.id == id}){
//            return child.tasks
//        } else {
//            return []
//        }
//    }
    
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
                            VStack{
                                Image("iconChildGrid")
                                Text("Child")
                                    .font(
                                        Font.custom("Pally-Bold", size: 24)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }.padding(.horizontal, 250)
                    }
                    //Card da criança
                    HistoryCardView(
                        mounthData: Data(),
                        taskState: Bool(true),
                        countTasks: Int(40),
                        goalsInProgress: Int(10),
                        totalCoins: Double(100),
                        piggyCoinsTrans: Double(20)
                    )
                    //TITULO TASK
                    Text("Tasks")
                        .font(
                            Font.custom("Pally-Bold", size: 28)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    TaskCreateCard(dayCount: 1)
                    Spacer()
                    //TASKS FEITAS
                    
                    
                }.padding(.horizontal, 85)
            }
        }
    }
}
