import SwiftUI

struct TaskCardFront: View {
    
    @State var task: TaskModel
    var doneAction: () -> Void
    
    @ViewBuilder
    private func renderImage() -> some View {
        Rectangle()
          .foregroundColor(.clear)
          .background(
            Image("PigTest")
              .resizable()
              .aspectRatio(contentMode: .fit)
          )
    }
    
    @ViewBuilder
    private func renderDescription(description: String) -> some View {
        Text(description)
          .font(
            Font.custom("Pally Variable", size: 17)
              .weight(.medium)
          )
          .multilineTextAlignment(.center)
          .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
    }
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            CEffortTag(effortType: task.effort ?? .easy, taskValue: task.value)
            renderImage()
            renderDescription(description: task.taskDescription)
            VStack(alignment: .center, spacing: 8){
                CButton(text: "Mark as Done", action:{ doneAction() })
            }
        }
        .padding(24)
        .frame(width: 272, height: 304, alignment: .top)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(40)
        .shadow(color: Color(red: 0.73, green: 0.57, blue: 0.8), radius: 0, x: 0, y: 4)
    }
}

#Preview {
    TaskCardFront(task: TaskModel(taskDescription: "aaaa", value: 2), doneAction: {print("Done")})
}
