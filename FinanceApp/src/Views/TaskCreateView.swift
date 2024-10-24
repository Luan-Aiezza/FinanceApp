//
//  SwiftUIView.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 17/10/24.
//

import SwiftUI
import SwiftData

struct TaskCreateView: View {
    @Environment(\.modelContext) private var modelContext
    
    @ObservedObject private var parentViewModel = ParentViewModel()
    
    @State var taskDescription: String = ""
    @State var value: Float = 0.0
    @State var stringValue: String = ""
    @State var recurrent: Bool = true
    @State var selectedChild: ChildModel?
    //    @State var witchFrequency: frequencyTypes = .daily
    
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    @Query private var parents: [ParentModel]
    
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
                if let child = selectedChild {
                    let task = parentViewModel.addTaskChild(
                        child: child,
                        taskDescription: taskDescription,
                        value: stringValue,
                        recurrent: recurrent,
                        effort: .easy,
                        frequency: .daily
                    )
                    modelContext.insert(task)
                    try! modelContext.save()
                }
            }
        }
    }
}



#Preview {
    TaskCreateView()
}
