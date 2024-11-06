//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI
import SwiftData

struct TaskCard: View {
    @State var isFlipped: Bool = true
    
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskModel]
    @ObservedObject var cashViewModel: CashBoxViewModel
    
    var taskID: PersistentIdentifier
    
    func handleFlip() {
        isFlipped.toggle()
    }
    
    var body: some View {
        if let task = tasks.first(where: { $0.id == taskID }) {
            if task.isDone {
                TaskCardSuccess(task: task)
            } else {
                ZStack {
                    // Passando isFlipped como binding para TaskCardFront
                    TaskCardFront(task: task, doneAction: { withAnimation(.easeInOut) { isFlipped.toggle() } }, isFlipped: $isFlipped)
                        .rotation3DEffect(.degrees(isFlipped ? 0 : -90), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
                    
                    // Passando isFlipped como primeiro binding para TaskCardBack
                    TaskCardBack(isFlipped: $isFlipped, task: task, yesAction: {
                        cashViewModel.addCoinsOnWallet(amount: Int(task.value))
                        withAnimation(.easeInOut) { task.isDone.toggle() }
                    }, notYetAction: { withAnimation(.easeInOut) { isFlipped.toggle() } })
                        .rotation3DEffect(.degrees(isFlipped ? 90 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
                        .allowsHitTesting(!isFlipped)
                }
                .onDisappear() {
                    print("Disappeared")
                }
                .onChange(of: isFlipped) {
                    print("\(isFlipped)")
                }
            }
        }
    }
}


#Preview {
    //    TaskCard(thisTask: TaskModel(taskDescription: "Comer pão", value: 2.0, effort: .easy, frequency: .daily).persistentModelID)
//    TaskCard()
}
