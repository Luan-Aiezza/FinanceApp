//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI
import SwiftData

struct TaskCard: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskModel]
    
    var thisTask: PersistentIdentifier
    
    var body: some View {
        if let task = tasks.first(where: { $0.id == thisTask}){
            VStack{
                Text("Effort Type")
                Image(systemName: "person.fill")
                Text(task.taskDescription)
                Button(action: {task.isDone = true}){
                    Text("Mark as Done")
                        .background(task.isDone ? Color.green : Color.red)
                        .foregroundStyle(.white)
                }
                
            }
            .frame(width: 272, height: 304)
            .background(Color.gray)
        }
    }
}


#Preview {
    TaskCard(thisTask: TaskModel(taskDescription: "Comer pão", value: 2.0, effort: .easy, frequency: .daily).persistentModelID)
}
