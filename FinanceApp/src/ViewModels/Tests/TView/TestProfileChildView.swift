import SwiftUI
import SwiftData

struct TestProfileChildView: View {
    @Environment(\.modelContext) private var modelContext
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    @ObservedObject var profileChildViewModel: ProfileChildViewModel
    //    @State var view: some View = HistoryView()
    init(id: UUID) {
        self.id = id
        profileChildViewModel = .init(id: id)
        print("Criando View para \(id)")
    }
    
    @State var path: [PickerOptions] = [.profile]
    
    
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
            VStack(spacing: 32) {
                HStack(alignment: .center){
                    //Image("Property 1=b1")
                    Image("iconChildMIni")
                    Spacer(minLength: 20)
                    
                    ProfileChildPicker(viewModel: profileChildViewModel)
                    Spacer(minLength: 20)
                    
                    HStack{
                        Image("blackIconCoin")
                            .scaledToFill()
                        Text("\(String(profileChildViewModel.wallet?.coins ?? 2))")
                            .foregroundStyle(Color.black)
                    }.frame(minWidth: 83, minHeight: 44)
                    .background(Color(red: 1, green: 0.83, blue: 0.21))
                    .cornerRadius(24)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.85, green: 0.67, blue: 0.01))
                        
                    )
                    .scaledToFit()
                    
                }
            .padding(.horizontal, 32)
                profileChildViewModel.changeView(for: profileChildViewModel.actualView)
                    .id(profileChildViewModel.actualView)
                    .transition(.opacity)
            }
            .onAppear(){
                if let child = childs.first(where: { $0.id == id }){
                    self.child = child
                }
                profileChildViewModel.modelContext = modelContext
                profileChildViewModel.fetch()
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
}
