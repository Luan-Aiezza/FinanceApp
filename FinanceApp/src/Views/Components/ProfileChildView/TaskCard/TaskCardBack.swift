import SwiftUI

struct TaskCardBack: View {
    @State var task: TaskModel
    @State var yesAction: () -> Void
    @State var notYetAction: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            renderTittle()
            VStack(alignment: .center, spacing: 8){
                CButton(text: "Yes",action: { yesAction()})
                CButton(text: "Not Yet",action: {notYetAction()})
            }
            
        }
        .padding(24)
        .frame(width: 272, height: 304, alignment: .top)
        .background(Color("CardBG"))
        .cornerRadius(40)
        .shadow(color: Color("CardShadowBG"), radius: 0, x: 0, y: 4)
        
    }
    
    @ViewBuilder
    func renderTittle() -> some View {
        VStack(alignment: .center, spacing: 24) {
                        Text("Did you complete this task?")
                            .font(
                              Font.custom("Pally Variable", size: 28)
                                .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("CardTextTP"))
                            .frame(maxWidth: .infinity, alignment: .center)
                        VStack(alignment: .center, spacing: 8) {
                            Text("\(task.taskDescription)")
                              .font(
                                Font.custom("Pally Variable", size: 14)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color("CardTextTP"))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("DescriptionTagBG"))
                        .cornerRadius(24)
                        .overlay(
                          RoundedRectangle(cornerRadius: 24)
                            .inset(by: 0.5)
                            .stroke(Color("DescriptionTagST"), lineWidth: 1)
                        )
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    TaskCardBack(task:  TaskModel(taskDescription: "Testing Task Card Back",value: 0), yesAction:{print("Yes Pressed")}, notYetAction: {print("Not Yet Pressed")})
}
