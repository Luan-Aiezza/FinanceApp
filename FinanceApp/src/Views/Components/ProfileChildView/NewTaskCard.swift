//
//  NewTaskCard.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 28/10/24.
//

import SwiftUI
import SwiftData

struct NewTaskCard: View {
    @ScaledMetric(relativeTo: .largeTitle) var imageWidth = 272
    @ScaledMetric(relativeTo: .largeTitle) var imageHeight = 304
    
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskModel]
    
    var taskID: PersistentIdentifier
    
    @ViewBuilder
    private func renderImage() -> some View {
        Rectangle()
          .foregroundColor(.clear)
          .background(
            Image("PigTest")
              .resizable()
              .aspectRatio(contentMode: .fit)
          )
          .scaledToFill()
    }
    
    @ViewBuilder
    private func renderDescription(description: String) -> some View {
        Text(description)
            .font(
                Font.custom("Pally-Bold", size: 17)
                    .weight(.medium)
            )
          .multilineTextAlignment(.center)
          .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
          .scaledToFill()
    }
    var body: some View{
        if let task = tasks.first(where: { $0.id == taskID }) {
            VStack(alignment: .center, spacing: 16) {
                CEffortTag(effortType: task.effort ?? .easy, taskValue: task.value)
                renderImage()
                renderDescription(description: task.taskDescription)
                CButton(text: "Mark as Done", action:{print("Button Pressed")})
            }
            .padding(24)
            .frame(width: imageWidth, height: imageHeight, alignment: .top)
            .background(Color(red: 0.94, green: 0.9, blue: 0.95))
            .cornerRadius(40)
            .shadow(color: Color(red: 0.73, green: 0.57, blue: 0.8), radius: 0, x: 0, y: 4)
        }
    }
}


//#Preview {
//    // Criação de um mock de TaskModel
//    @ViewBuilder
//    func testPreview() -> some View {
//        let mockTask = TaskModel(taskDescription: "Testar", value: 2)
//
//        // Instância do modelContainer para pré-visualização em memória
//        let schema = Schema([TaskModel.self])
//        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
//        let container = ModelContainer(configurations: config)
//        container.mainContext.insert(mockTask)
//
//        // Identificador para ser usado na pré-visualização
//        let mockTaskID = mockTask.id
//
//       NewTaskCard(taskID: mockTaskID)
//            .modelContainer(container)
//    }
//    testPreview()
//}
