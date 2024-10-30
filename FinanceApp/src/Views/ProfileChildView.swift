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
<<<<<<< HEAD
                    HStack{
//                        Spacer(minLength: 85)
                        Image("iconChildMini")
                        ProfileChildPicker(viewModel: profileChildViewModel)
                        Image("blackIconCoin")
                            .frame(width: 44, height: 33)
                            .background(Color(red: 1, green: 0.83, blue: 0.21))
                            .cornerRadius(24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.85, green: 0.67, blue: 0.01), lineWidth: 1)
                            )
//                        Spacer(minLength: 85)
=======
                    HStack {
                        // Ícone da criança no canto superior esquerdo
                        Button(action: {
                            // Ação do botão (ex: abrir perfil da criança)
                        }) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        // Toolbar com três opções (exemplo de ícones)
                        HStack(spacing: 20) {
                            Button(action: {
                                // Ação 1
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {
                                // Ação 2
                            }) {
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {
                                // Ação 3
                            }) {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()

                        // Ícone da Cash Box (moeda) no canto superior direito
//                        NavigationLink(destination: CashBoxView2( id: //<#UUID#>)) {
//                            Image(systemName: "person.fill")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(.yellow)
//                        }
//                        .padding(.trailing, 16)
>>>>>>> CashBox_updates
                    }
                    Spacer()
                    profileChildViewModel.changeView(for: profileChildViewModel.actualView)
                        .id(profileChildViewModel.actualView)
                        .transition(.opacity)
                }.padding(.horizontal, 85)
            
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
