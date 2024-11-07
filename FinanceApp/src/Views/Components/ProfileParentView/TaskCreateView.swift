
import SwiftUI
import SwiftData

struct TaskCreateView: View {
    @Environment(\.modelContext) private var modelContext
    
    @ObservedObject private var parentViewModel = ParentViewModel()
    
    @State var taskDescription: String = ""
    @State var value: Int = 0
    @State var stringValue: String = ""
    @State var recurrent: Bool = true
    @State var selectedChild: ChildModel?
    //    @State var witchFrequency: frequencyTypes = .daily
    
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    @Query private var parents: [ParentModel]
    
    var body: some View {
        VStack() {
            HStack {
                Button("Cancel") {
                    
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text("New Task")
                    .foregroundColor(.primary)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                Spacer()
                
                Button("Done") {
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
                    if let parent = parents.first {
                        print(parent.name)
                        print(parent.childs)
                    }
                }
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                .foregroundColor(.mediumPurple)
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            Form{
                
                // TODO: Trocar de picker para alguma outra coisa
                Picker("Select child",selection: $selectedChild){
                    if let childs = parents.first?.childs{
                        ForEach(childs){ child in
                            Text(child.name).tag(child)
                        }
                    }
                }.font(
                    Font.custom("Pally-Regular", size: 17)
                        .weight(.medium)
                )
                    TextField("Add a description to this task: ", text: $taskDescription).font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                
                    TextField("Type the value of this task: ", text: $stringValue).font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    ).keyboardType(.decimalPad)
                Toggle("Is recurrent? ",isOn: $recurrent).font(
                    Font.custom("Pally-Regular", size: 17)
                        .weight(.medium)
                )
            }.scrollContentBackground(.hidden)
        }
        .padding()
        .cornerRadius(20)
        
    }
    
}
