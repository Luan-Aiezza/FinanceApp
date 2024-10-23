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
    @State var selectedChild: ChildModel?
//    @State var witchFrequency: frequencyTypes = .daily
    
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    @Query private var parents: [ParentModel]
    
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
                Section{
                    // TODO: Trocar de picker para alguma outra coisa
                    Picker("Selecione o filho",selection: $selectedChild){
                        if let childs = parents.first?.childs{
                            ForEach(childs){ child in
                                Text(child.name).tag(child)
                            }
                        }
                    }
                }
//                Section{
//                    // TODO: Refatorar depois
//                    Picker("Diário?", selection: $witchFrequency){
//                        Text("Daily").tag(frequencyTypes.daily)
//                        Text("Weekly").tag(frequencyTypes.weekly)
//                        Text("Montly").tag(frequencyTypes.monthly)
//                        
//                    }
//                }
            }
        }
        HStack{
            Button("Create task"){
                let newTask = TaskModel(taskDescription: taskDescription, value: convertStrigToFloat(value: stringValue), recurrent: recurrent, effort: .easy, frequency: .daily)
                
                if let child = childs.first{
                    parentViewModel.createTask(child: child, taskToAdd: newTask)
                    
                    modelcontext.insert(newTask)
                }
            }
        }
    }
    
}


#Preview {
    TaskCreateView()
}
