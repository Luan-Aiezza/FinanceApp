import SwiftUI
import SwiftData

struct ProfileChildView: View {
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
            ZStack {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                VStack {
                    // Toolbar com ícone da criança e caixa de moedas
                    ProfileChildPicker(viewModel: profileChildViewModel)
                    Spacer()
                    profileChildViewModel.changeView(for: profileChildViewModel.actualView)
                        .id(profileChildViewModel.actualView)
                        .transition(.opacity)
                }
            }
            .onAppear(){
                if let child = childs.first(where: { $0.id == id }){
                    self.child = child
                }
            }
            .onChange(of: profileChildViewModel.actualView){
//                print(profileChildViewModel.actualView)
            }
//        }
    }
}

#Preview {
    ProfileChildView(id:UUID())
        .modelContainer(for: Item.self, inMemory: true)
}
