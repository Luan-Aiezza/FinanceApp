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
    @State var selectedEffortLevel: EffortLevel = .low // Valor padrão do Picker
    
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    @Query private var parents: [ParentModel]
    
    enum EffortLevel: Int, CaseIterable, Identifiable {
        case low = 1
        case medium = 3
        case high = 5
        
        var id: Int { self.rawValue }
        
        var description: String {
            switch self {
            case .low: return "Low Effort"
            case .medium: return "Medium Effort"
            case .high: return "High Effort"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("Cancel") {
                    // Ação do botão de cancelamento
                }
                .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                .foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
                
                Spacer()
                
                Text("New Task")
                    .foregroundColor(.primary)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                Spacer()
                
                Button("Done") {
                    if let child = selectedChild {
                        stringValue = "\(selectedEffortLevel.rawValue)" // Atualiza stringValue com o valor selecionado
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
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                .foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
            }
            .padding([.bottom, .horizontal])
            
            Divider()
            
            Spacer()
            
            Text("Task name")
                .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
            
            TextField("", text: $taskDescription)
                .frame(minHeight: 44)
                .background(Color(red: 1, green: 1, blue: 1))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
            
            Text("How heavy is the task?")
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
            
            Picker("Select effort", selection: $selectedEffortLevel) {
                ForEach(EffortLevel.allCases) { level in
                    Text(level.description)
                        .tag(level)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color(red: 1, green: 1, blue: 1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .font(Font.custom("Pally-Regular", size: 17).weight(.bold))
            
            Spacer()
        }
        .padding()
    }
}

//Picker("Select child",selection: $selectedChild){
//    if let childs = parents.first?.childs{
//        ForEach(childs){ child in
//            Text(child.name).tag(child)
//        }
//    }
//}.font(
//    Font.custom("Pally-Regular", size: 17)
//        .weight(.medium)
//)


//TextField("", text: $stringValue)
//    .background(Color(red: 1, green: 1, blue: 1))
//    .clipShape(.rect(cornerRadius: 10.0))
//    .font(
//    Font.custom("Pally-Regular", size: 17)
//        .weight(.medium)
//).keyboardType(.decimalPad)
