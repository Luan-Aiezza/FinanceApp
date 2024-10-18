//
//  SwiftUIView.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 17/10/24.
//

import SwiftUI
import SwiftData

struct TaskCreateView: View {
    @Environment(\.modelContext) private var modelcontext

    private var parentViewModel: ParentViewModel = .init()
    @State var taskDescription: String = ""
    @State var value: Float = 0.0
    @State var stringValue: String = "0.0"
    @State var recurrent: Bool = true
    
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    
    func convertStrigToFloat(value: String) -> Float {
        if let value = Float(value){
            return value
        } else {
            return 0.0
        }
    }
    
    var body: some View {
        HStack{
            Form {
                TextField("Add a description to this task: ", text: $taskDescription)
                TextField("Type the value of this task: ", text: $stringValue)
                    .keyboardType(.decimalPad)
                Toggle("Is recurrent? ",isOn: $recurrent)
            }
            HStack{
                Button("Create task"){
                    let newTask = TaskModel(taskDescription: taskDescription, value: convertStrigToFloat(value: stringValue), recurrent: recurrent)
                    
                    if let child = childs.first{
                        parentViewModel.createTask(child: child, taskToAdd: newTask)
                        
                        modelcontext.insert(newTask)
                    }
                }
                Button("Show Data"){
                    if let value = childs.first?.tasks.first{
                        print(value.taskDescription)
                    }
                }
                Button("Create child"){
                    let newChild = ChildModel(name: "Zé")
                    modelcontext.insert(newChild)
                }
            }
        }
        
    }
}

#Preview {
    TaskCreateView()
}
