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
                    HStack{
                        // Botão com imagem
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    NavigationLink(destination: TaskCreateView()){
                        Text("Criar Tarefa")
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileParentView()
        .modelContainer(for: Item.self, inMemory: true)
}
