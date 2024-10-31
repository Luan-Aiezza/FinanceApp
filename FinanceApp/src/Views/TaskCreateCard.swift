import SwiftUI
import SwiftData

struct TaskCreateCard: View {
    
    var dayCount: Int = 0
    @State private var showPopover = false
    
    var body: some View {
        
        HStack(alignment: .center) {
            Text("Day \(dayCount)")
            .font(
            Font.custom("Pally Variable", size: 22)
            .weight(.bold)
            )
            .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            Spacer()
            //BOTOES
            Button(action: {
                //Copy to all week
            }) {
                HStack {
                    Image(systemName: "folder")
                    Text("Copy to all week")
                        .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.purple)
                .cornerRadius(20)
            }
            .padding(.trailing)
            
            Button(action: {
                //New Task
                showPopover.toggle()
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("New task")
                        .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.purple)
                .cornerRadius(20)
            }
            .popover(isPresented: $showPopover) {
                TaskCreateView() // Exibe a TaskCreateView dentro do popover
                    .frame(width: 400, height: 600) // Defina um tamanho desejado
            }
            .padding(.trailing)
            
        }
        .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.94, green: 0.9, blue: 0.95))
            .cornerRadius(22)
            .overlay(
            RoundedRectangle(cornerRadius: 24)
            .inset(by: -2)
            .stroke(Color(red: 0.85, green: 0.76, blue: 0.89), lineWidth: 4)
            )


    }
}
