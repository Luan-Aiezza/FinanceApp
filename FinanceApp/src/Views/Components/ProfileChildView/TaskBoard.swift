//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI

struct TaskBoard: View {
    
    var tasks: [TaskModel]
    let gridItem = [GridItem(.adaptive(minimum: 300))]
    
    var body: some View {
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
