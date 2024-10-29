//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI
import SwiftData

struct TaskBoard: View {
    
    //    var tasks: [TaskModel]
    
    @Environment(\.modelContext) private var modelContext
    @Query private var childs: [ChildModel]
    let id: UUID
    
    let gridItem = [GridItem(.adaptive(minimum: 300))]
    
    var body: some View {
        if let tasks = childs.first(where:{$0.id == id})?.tasks {
            VStack{
                ScrollView(.vertical) {
                    LazyVGrid(columns: gridItem) {
                        ForEach(tasks) { task in
                            NewTaskCard(taskID: task.persistentModelID)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
            }
            
            //        #Preview {
            //            TaskCard(thisTask: TaskModel(taskDescription: "Comer pão", value: 2.0))
            //        }
        }
    }
}

