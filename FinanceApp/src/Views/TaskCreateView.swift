//
//  SwiftUIView.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 17/10/24.
//

import SwiftUI

struct TaskCreateView: View {
    private var parentViewModel: ParentViewModel = .init()
    @State var taskDescription: String = ""
    @State var value: Float = 0.0
    @State var stringValue: String = "0.0"
    @State var recurrent: Bool = true
    @State var child: ChildModel = .init(name: "Zezinho")
    
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
                    parentViewModel.createTask(child: child, taskDescription: taskDescription, value: value, recurrent: recurrent)
                }
                Button("Show Data"){
                    if let value = child.task.first{
                        print(value.taskDescription)
                    }
                }
            }
        }
        
    }
}

#Preview {
    TaskCreateView()
}
