import SwiftUI
import SwiftData

struct ProfileChildView: View {
    @Environment(\.modelContext) private var modelContext
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("GreenBackground")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    // Toolbar com ícone da criança e caixa de moedas
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
                        NavigationLink(destination: CashBoxView()) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.yellow)
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.top, 16)
                    
                    // Calendário simples (indicando mês)
                    Text("Outubro 2024")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    
                    // Carrossel vertical para exibir as tarefas
//                    ScrollView(.vertical) {
//                        VStack(spacing: 16) {
//                            ForEach(items) { item in
//                                TaskCardView(task: item)
//                                    .frame(width: 300, height: 150)
//                                    .background(Color.white)
//                                    .cornerRadius(12)
//                                    .shadow(radius: 5)
//                            }
//                        }
//                        .padding(.horizontal, 16)
//                    }
                    
                    Spacer()
                    if let child = childs.first(where: {$0.id == id}){
                        ForEach(child.tasks){ task in
                            Text(task.taskDescription)
                        }
                    }
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
