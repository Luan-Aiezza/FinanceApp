//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI

struct TaskCard: View {
    
    let thisTask: TaskModel
    
    var body: some View {
        VStack{
            Text("Effort Type")
            Image(systemName: "person.fill")
            Text(thisTask.taskDescription)
            Button(action: {}){
                Text("Mark as Done")
                    .background(Color.blue)
                    .foregroundStyle(.white)
            }
            
        }
        .frame(width: 272, height: 304)
        .background(Color.gray)
    }
}

#Preview {
    TaskCard(thisTask: TaskModel(taskDescription: "Comer pão", value: 2.0))
}
