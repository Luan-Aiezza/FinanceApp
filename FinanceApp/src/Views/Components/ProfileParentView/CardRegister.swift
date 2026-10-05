import SwiftUI
import SwiftData

struct TaskSection: View {
    @Binding var selectedChild: ChildModel
    var addTask: (_ child: ChildModel, _ taskDescription: String, _ value: String, _ recurrent: Bool, _ effort: EffortTypes, _ frequency: FrequencyTypes) -> Void
    
    var body: some View {
        Text("Tasks")
            .font(Font.custom("Pally-Bold", size: 28).weight(.medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        
        TaskCreateCard(selectedChild: selectedChild, addTask: addTask)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
    }
}

struct TaskRegisters: View {
    @Binding var tasks: [TaskModel]
    
    var body: some View {
        ScrollView{
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 32),
                    GridItem(.flexible(), spacing: 32)
                ],
                spacing: 32
            ) {
                ForEach(tasks) { task in
                    RegisterTask(task: task)
                }
            }.padding(.vertical)
        }
    }
}


struct RegisterTask: View {
    var task: TaskModel
    @State var popover: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16){
            CEffortTag(effortType: task.effort!, taskValue: task.value)
            Text(task.taskDescription)
                .font(
                    Font.custom(
                        "Pally-Bold", size: 17
                    ).weight(.medium)
                )
        }
        .frame(maxWidth: .infinity, minHeight: 112, alignment: .center)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(40)
        .background(
            RoundedRectangle(cornerRadius:40)
                .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                .offset(x:0, y: 6)
        )
        .popover(isPresented: $popover){
            PopOverCard(task: task)
        }
        .onLongPressGesture(perform: {popover.toggle()})
        
    }
}

struct PopOverCard: View {
    @EnvironmentObject var parentViewModel: ParentViewModel
    @State var showEdit: Bool = false
    var task: TaskModel
    private func renderDeleteButton() -> some View {
        Button(action: {parentViewModel.deleteTask(task: task)}){
            HStack{
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .font(.system(size: 24))
                Text("Delete")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .medium))
            }
        }
    }
    private func renderEditButton() -> some View {
        Button(action: {showEdit.toggle()}){
            HStack{
                Image(systemName: "pencil")
                    .foregroundColor(.purple)
                    .font(.system(size: 24))
                Text("Edit")
                    .foregroundColor(.purple)
                    .font(.system(size: 16, weight: .medium))
            }
        }
    }
    
    var body: some View {
        VStack{
            if !showEdit
            {
                List{
                    renderDeleteButton()
                    renderEditButton()
                }
                .frame(width: 300, height: 200)
            }
            else {PopOverEditTask(task: task, showEdit: $showEdit)}
        }
    }
}

struct PopOverEditTask: View {
    var task: TaskModel
    @EnvironmentObject var parentViewModel: ParentViewModel
    @Environment(\.dismiss) private var  dismiss
    @Binding var showEdit: Bool
    @State var taskDescription: String = ""
    @State var selectedEffortLevel: EffortTypes = .easy

    var body: some View {
        headerButtons()
        Divider()
        editTask()
    }
    
    private func headerButtons() -> some View {
        HStack{
            Button("Cancel") {
                showEdit.toggle()
            }
            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
            .foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
            Spacer()
            Text("Edit Task")
            Spacer()
            Button("Done") {
                parentViewModel.updateTask(task: task, description: taskDescription, effort: selectedEffortLevel)
                dismiss()
                parentViewModel.fetch(id: task.child?.id)
                print("Passei Pelo fetch do header")
            }
            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
            .foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
            
        }
    }
    private func editTask() -> some View {
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
        .onAppear{
            taskDescription = task.taskDescription
            guard let effort = task.effort else { return }
            selectedEffortLevel = effort
        }
    }
}
