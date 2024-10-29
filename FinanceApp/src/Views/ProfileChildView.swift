import SwiftUI
import SwiftData

struct ProfileChildView: View {
    @Environment(\.modelContext) private var modelContext
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    func getTasks() -> [TaskModel] {
        if let child = childs.first(where: {$0.id == id}){
            return child.tasks
        } else {
            return []
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                VStack {
                    // Toolbar com ícone da criança e caixa de moedas
                    ProfileChildPicker()
                    TaskBoard(tasks: getTasks())
                    Spacer()
                }
            }
            .onAppear(){
                if let child = childs.first(where: { $0.id == id }){
                    self.child = child
                }
                else { return }
            }
        }
    }
}

//struct TaskCardView: View {
//    var task: Item
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(task.name)
//                .font(.headline)
//            Text(task.description)
//                .font(.subheadline)
//        }
//        .padding()
//    }
//}

#Preview {
    ProfileChildView(id:UUID())
        .modelContainer(for: Item.self, inMemory: true)
}
