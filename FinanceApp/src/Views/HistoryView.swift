import SwiftUI
import SwiftData

struct HistoryView: View {

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
                    
                    Text("BEM-VINDO")
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
    HistoryView()
        .modelContainer(for: Item.self, inMemory: true)
}
