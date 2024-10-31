//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI
import SwiftData



struct TaskCard: View {
    @State var isDone: Bool = false
    @State var isFlipped: Bool = true
    
    func handleFlip(){
        isFlipped.toggle()
    }
    
    var body: some View {
        if isDone {
            TaskCardSuccess()
        } else {
            ZStack{
                TaskCardFront(doneAction: {withAnimation(.easeInOut){isFlipped.toggle()}})
                    .rotation3DEffect(. degrees(isFlipped ? 0 : -90), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
                
                TaskCardBack(yesAction: { withAnimation(.easeInOut){isDone.toggle()}}, notYetAction: {withAnimation(.easeInOut){isFlipped.toggle()}})
                    .rotation3DEffect(. degrees(isFlipped ? 90 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
                    .allowsHitTesting(!isFlipped)
            }
            .onDisappear(){
                print("Disappeared")
            }
            .onChange(of: isFlipped){
                print("\(isFlipped)")
            }
//            .onTapGesture {
//                withAnimation(.easeInOut){
//                    isFlipped.toggle()
//                }
//            }
        }
    }
}
#Preview {
//    TaskCard(thisTask: TaskModel(taskDescription: "Comer pão", value: 2.0, effort: .easy, frequency: .daily).persistentModelID)
    TaskCard()
}
