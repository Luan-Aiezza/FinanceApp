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
                VStack(alignment: .leading, spacing: 20){
                    Spacer()
                    //TITULO HISTORY
                    Text("History")
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
                    
//                    VStack(alignment: .center, spacing: 12) {
//                        RoundedRectangle(cornerRadius: 24)
//                            .inset(by: -2)
//                            .stroke(Color(red: 0.85, green: 0.76, blue: 0.89), lineWidth: 4)
//                        RoundedRectangle(cornerRadius: 24)
//                            .inset(by: -2)
//                            .stroke(Color(red: 0.85, green: 0.76, blue: 0.89), lineWidth: 4)
//                        RoundedRectangle(cornerRadius: 24)
//                            .inset(by: -2)
//                            .stroke(Color(red: 0.85, green: 0.76, blue: 0.89), lineWidth: 4)
//                        RoundedRectangle(cornerRadius: 24)
//                            .inset(by: -2)
//                            .stroke(Color(red: 0.85, green: 0.76, blue: 0.89), lineWidth: 4)
//                        RoundedRectangle(cornerRadius: 24)
//                            .inset(by: -2)
//                            .stroke(Color(red: 0.85, green: 0.76, blue: 0.89), lineWidth: 4)
//                    }
                    
                    

                    
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
