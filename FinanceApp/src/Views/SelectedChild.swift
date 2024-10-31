import SwiftUI
import SwiftData

struct SelectedChild: View {

    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack(alignment: .leading){
                    //TITULO HISTORY
                    Text("Create Task")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .font(
                        Font.custom("Pally Variable", size: 24)
                        .weight(.medium)
                        )
                        .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color(red: 0.36, green: 0, blue: 0.55))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.36, green: 0, blue: 0.55), lineWidth: 1)
                        )
                    //Card da criança
                    VStack(alignment: .leading) {
                        Text("Selected children")
                        HStack{
                            Image("childIcon")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.cyan)
                                .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                            VStack{
                                Text("Rodrigo")
                                Text("8 anos")
                            }
                        }.padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(red: 0.94, green: 0.9, blue: 0.95))
                            .cornerRadius(24)
                    }
                    
                    Text("Tasks")
                    
                    ScrollView {
                        VStack() {
                            ForEach(1..<8) { index in
                                TaskCreateCard(dayCount: index)
                            }.padding(.bottom, 20)
                        }
                    }
                    Spacer()

                }.padding(.horizontal, 85)
            }
        }
    }
}
