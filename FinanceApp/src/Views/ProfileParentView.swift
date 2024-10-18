import SwiftUI
import SwiftData

struct ProfileParentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Image("GreenBackground")
                    .resizable()
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack{
                    Text("BEM-VINDO SENHOR JOSÉ")
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
                }
            }
        }
        
    }
}

#Preview {
    ProfileParentView()
        .modelContainer(for: Item.self, inMemory: true)
}
