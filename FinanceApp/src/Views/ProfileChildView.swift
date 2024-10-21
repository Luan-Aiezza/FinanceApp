import SwiftUI
import SwiftData

struct ProfileChildView: View {
    @Environment(\.modelContext) private var modelContext
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Image("GreenBackground")
                    .resizable()
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack{
                    Text("BEM-VINDO \(child?.name ?? "Sem nome")!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    Spacer()
                    HStack{
                        // Botão com imagem
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.cyan)
                    }
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

#Preview {
    ProfileChildView(id:UUID())
        .modelContainer(for: Item.self, inMemory: true)
}
