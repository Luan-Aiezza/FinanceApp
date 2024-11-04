import SwiftUI
import SwiftData

struct SelectedChild: View {
    @Environment(\.modelContext) private var modelContext
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    @ObservedObject var profileChildViewModel: ProfileChildViewModel
    //    @State var view: some View = HistoryView()
    init(id: UUID) {
        self.id = id
        profileChildViewModel = .init(id: id)
    }
    
    
    func getTasks() -> [TaskModel] {
        if let child = childs.first(where: {$0.id == id}){
            return child.tasks
        } else {
            return []
        }
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
                    //TITULO HISTORY
                    Text("Create Task")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .font(
                            Font.custom("Pally-Bold", size: 24)
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
                    TaskCreateCard(dayCount: 1)
                    Spacer()
                    
                }.padding(.horizontal, 85)
            }
        }
    }
}
