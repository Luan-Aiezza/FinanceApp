import SwiftUI
import SwiftData

struct TaskCreateCard: View {
    
    var dayCount: Int = 0
    @State private var showPopover = false
    
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Tasks for today")
                .font(
                    Font.custom("Pally-Bold", size: 22)
                        .weight(.medium)
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
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
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
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(20)
            }
            .popover(isPresented: $showPopover) {
                TaskCreateView()// Exibe a TaskCreateView dentro do popover
                    .frame(width: 500, height: 350)
                    .background(Color.white)// Define a cor de fundo do popover
                    .preferredColorScheme(.light) // Força o modo claro
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .leading)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .clipShape(.rect(cornerRadius: 24.0))
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.85, green: 0.76, blue: 0.89))
                .offset(x:0, y: 6)
        )
    }
    
    //            .shadow(color:Color(red: 1.0, green: 0.0, blue: 0.0), radius: 24, x: 0, y: -18)
    //
    
}

