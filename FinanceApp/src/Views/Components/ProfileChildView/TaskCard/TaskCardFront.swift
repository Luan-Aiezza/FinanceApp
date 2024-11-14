import SwiftUI

struct TaskCardFront: View {
    
    
    @ScaledMetric(relativeTo: .largeTitle) var imageWidth = 272
    @ScaledMetric(relativeTo: .largeTitle) var imageHeight = 304
    
    @State var task: TaskModel
    var doneAction: () -> Void
    @Binding var isFlipped: Bool  // Estado para controlar a posição do card
    
    @ViewBuilder
    private func renderImage() -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                Image("PigTest")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
            .accessibilityHidden(isFlipped)  // Oculta imagem do VoiceOver quando virado
    }
    
    @ViewBuilder
    private func renderDescription(description: String) -> some View {
        Text(description)
            .font(Font.custom("Pally Variable", size: 17).weight(.medium))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            .accessibilityHidden(isFlipped)  // Oculta descrição do VoiceOver quando virado
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            CEffortTag(effortType: task.effort ?? .easy, taskValue: task.value)
                .accessibilityHidden(isFlipped)  // Oculta tag de esforço quando virado
            renderImage()
            renderDescription(description: task.taskDescription)
            VStack(alignment: .center, spacing: 8) {
                CButton(
                    text: NSLocalizedString("Mark as Done", comment: "Button to mark task as completed"),
                    action: {
                        doneAction()
//                        isFlipped = true  // Vira o card ao marcar como concluído
                    }
                )
                .accessibilityHidden(isFlipped)  // Oculta botão quando virado
            }
        }
        .padding(24)
        .frame(width: imageWidth, height: imageHeight, alignment: .top)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(40)
        .shadow(color: Color(red: 0.73, green: 0.57, blue: 0.8), radius: 0, x: 0, y: 4)
        .accessibilityHidden(isFlipped)  // Oculta toda a frente quando virado
    }
}
