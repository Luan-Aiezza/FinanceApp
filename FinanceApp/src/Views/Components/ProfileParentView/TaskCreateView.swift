import SwiftUI
import SwiftData

struct TaskCreateView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject private var parentViewModel = ParentViewModel.shared
    
    @State var taskDescription: String = ""
    @State var value: Int = 1
    @State var stringValue: String = ""
    @State var recurrent: Bool = true
    @State var selectedChild: ChildModel?
    @State var selectedEffortLevel: EffortTypes = .easy
    @Binding var isPresented: Bool
    
    @State var isChangeTask: Bool = false
    
    @State private var showAlert = false // Controle para exibir o alerta
    @Query private var childs: [ChildModel]
    @Query private var tasks: [TaskModel]
    @Query private var parents: [ParentModel]
    
    var addTask: (_ child: ChildModel, _ taskDescription: String, _ value: String, _ recurrent: Bool, _ effort: EffortTypes, _ frequency: FrequencyTypes) -> Void
    
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
                    if taskDescription.isEmpty /*|| selectedEffortLevel == EffortTypes*/ {
                        showAlert = true // Exibe o alerta se algum campo obrigatório estiver vazio
                    } else if let child = selectedChild {
                        addTask(child, taskDescription, String(value), false, selectedEffortLevel, .none)
                        parentViewModel.isChangeTaskDone.toggle()
                        isPresented = false
                    }
                    // isPresented = false // Fecha o Popover ao clicar em "Done"
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
                
                EffortSection(selectedEffortLevel: $selectedEffortLevel)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
        .onChange(of: selectedEffortLevel) {
            switch selectedEffortLevel {
            case .easy:
                value = 1
            case .medium:
                value = 3
            case .hard:
                value = 5
            }
        }
    }
}

struct EffortSection: View {
    @Binding var selectedEffortLevel: EffortTypes
    
    var body: some View {
        HStack {
            Text("Select effort")
                .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
            Spacer()
            EffortPicker(selectedEffortLevel: $selectedEffortLevel)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
    }
}

struct EffortPicker: View {
    @Binding var selectedEffortLevel: EffortTypes
    var body: some View {
        Picker("Select effort", selection: $selectedEffortLevel) {
            ForEach(EffortTypes.allCases, id: \.self) { level in
                Text(level.rawValue.capitalized)
                    .font(Font.custom("Pally-Regular", size: 17).weight(.bold))
                    .tag(level)
                    .padding()
            }
        }
        .pickerStyle(MenuPickerStyle())
        .padding(.leading, 8)
        .foregroundColor(Color.black)
    }
}
