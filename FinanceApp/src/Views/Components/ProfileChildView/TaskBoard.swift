//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI

struct TaskBoard: View {
    
    let tasks: [TaskModel]
    let gridItem = [GridItem(.adaptive(minimum: 300))]
    
    var body: some View {
        VStack{
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItem) {
                    ForEach(tasks) { task in
                        TaskCard(thisTask: task)
                            .frame(width: 300, height: 150)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
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
