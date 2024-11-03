import SwiftUI
import SwiftData

struct ProfileParentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var parent: [ParentModel]
    
    func getName() -> String {
        if let name = parent.first?.name {
            return name
        }
        return "guardian"
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
                VStack{
                    Text("BEM-VINDO SENHOR \(getName())")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    Spacer()
                    //NavigationLink(destination: SelectedChild()){
                        VStack{
                            Image("childIcon")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.cyan)
                                .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                                .overlay(
                                    Circle().stroke(Color.purple, lineWidth: 4) // Borda branca opcional para destaque
                                )
                            Text("Criar Tarefa")
                        }
                    }
                    Spacer()
                }.padding(.horizontal, 85)
            }
        }
    }
//}

#Preview {
    ProfileParentView()
        .modelContainer(for: Item.self, inMemory: true)
}
