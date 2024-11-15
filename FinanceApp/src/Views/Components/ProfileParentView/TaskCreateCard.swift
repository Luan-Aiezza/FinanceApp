import SwiftUI
import SwiftData

struct TaskCreateCard: View {
    @State private var showPopover = false
    @State private var keyboardHeight: CGFloat = 0 // Estado para armazenar a altura do teclado
    @State var selectedChild: ChildModel?
    var addTask: (_ child: ChildModel, _ taskDescription: String, _ value: String, _ recurrent: Bool, _ effort: EffortTypes, _ frequency: FrequencyTypes) -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Tasks for today!")
                .font(
                    Font.custom("Pally-Bold", size: 22)
                        .weight(.medium)
                )
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            Spacer()
            
            // Botão para exibir o Popover
            Button(action: {
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
                .cornerRadius(24)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                        .offset(x:0, y: 6)
                )
            }
            .popover(isPresented: $showPopover, arrowEdge: .bottom) {
                TaskCreateView(selectedChild: selectedChild, isPresented: $showPopover, addTask: addTask) // Exibe a TaskCreateView dentro do Popover
                    .frame(minWidth: 500, minHeight: 300)
                        .background(Color.white)// Define a cor de fundo do popover
                        .preferredColorScheme(.light) // Força o modo claro
            }.padding(.trailing)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .leading)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.85, green: 0.76, blue: 0.89))
                .offset(x:0, y: 6)
        )
    }
}



