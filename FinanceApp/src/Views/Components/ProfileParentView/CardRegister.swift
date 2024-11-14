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
    }
}
