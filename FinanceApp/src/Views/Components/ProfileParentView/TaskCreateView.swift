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
    @State var selectedEffortLevel: EffortLevel = .none
    @Binding var isPresented: Bool
    
    @State private var showAlert = false // Controle para exibir o alerta
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    @Query private var parents: [ParentModel]
    
    enum EffortLevel: Int, CaseIterable, Identifiable {
        case none = 0
        case low = 1
        case medium = 3
        case high = 5
        
        var id: Int { self.rawValue }
        
        var description: String? {
            switch self {
            case .none: return nil
            case .low: return "Low Effort"
            case .medium: return "Medium Effort"
            case .high: return "High Effort"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                .foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
                
                Spacer()
                
                Text("New Task")
                    .foregroundColor(.primary)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                Spacer()
                
                Button("Done") {
                    if taskDescription.isEmpty || selectedEffortLevel == .none {
                        showAlert = true // Exibe o alerta se algum campo obrigatório estiver vazio
                    } else if let child = selectedChild {
                        let task = parentViewModel.addTaskChild(
                            child: child,
                            taskDescription: taskDescription,
                            value: "\(value)", // Use o valor selecionado pelo usuário
                            recurrent: recurrent,
                            effort: .easy,
                            frequency: .daily
                        )
                        modelContext.insert(task)
                        try? modelContext.save()
                        isPresented = false
                    }
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                .foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
                .alert(isPresented: $showAlert) { // Configura o alerta com uma mensagem
                    Alert(
                        title: Text("Warning"),
                        message: Text("Please provide a task name and select an effort level."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding([.bottom, .horizontal])
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Task name")
                    .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                
                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                    
                    TextField("Enter task name", text: $taskDescription)
                        .padding(.leading, 8)
                        .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                Text("How heavy is the task?")
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                HStack {
                    Text("Select effort")
                        .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                    
                    Spacer()
                    
                    Picker("Select effort", selection: $selectedEffortLevel) {
                        ForEach(EffortLevel.allCases) { level in
                            Text(level.description ?? "")
                                .font(Font.custom("Pally-Regular", size: 17).weight(.bold))
                                .tag(level)
                                .padding()
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.leading, 8)
                    .foregroundColor(Color.black)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
    }
}
