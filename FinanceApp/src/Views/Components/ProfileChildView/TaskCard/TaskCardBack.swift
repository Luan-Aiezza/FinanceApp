import SwiftUI

struct TaskCardBack: View {
    @Binding var isFlipped: Bool
    @State var task: TaskModel
    var yesAction: () -> Void
    var notYetAction: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            renderTittle()
            VStack(alignment: .center, spacing: 8) {
                CButton(
                    text: NSLocalizedString("Yes", comment: "Confirmation button for completing task"),
                    action: { yesAction() }
                )
                .accessibilityHidden(!isFlipped)  // Visível apenas quando o card está virado
                
                CButton(
                    text: NSLocalizedString("Not Yet", comment: "Indicates task is not yet completed"),
                    action: { notYetAction() }
                )
                .accessibilityHidden(!isFlipped)  // Visível apenas quando o card está virado
            }
        }
        .padding(24)
        .frame(width: 272, height: 304, alignment: .top)
        .background(Color("CardBG"))
        .cornerRadius(40)
        .shadow(color: Color("CardShadowBG"), radius: 0, x: 0, y: 4)
        .accessibilityHidden(!isFlipped)  // Oculta a parte de trás inteira quando não está virada
    }
    
    @ViewBuilder
    func renderTittle() -> some View {
        VStack(alignment: .center, spacing: 24) {
            Text(NSLocalizedString("Did you complete this task?", comment: "Prompt asking if the task was completed"))
                .font(Font.custom("Pally Variable", size: 28).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("CardTextTP"))
                .frame(maxWidth: .infinity, alignment: .center)
                .accessibilityHidden(!isFlipped)  // Visível apenas quando o card está virado
            
            VStack(alignment: .center, spacing: 8) {
                Text("\(task.taskDescription)")
                    .font(Font.custom("Pally Variable", size: 14).weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("CardTextTP"))
                    .accessibilityHidden(!isFlipped)  // Visível apenas quando o card está virado
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
