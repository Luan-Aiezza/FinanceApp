import SwiftUI
import SwiftData

struct SelectedChild: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var parentViewModel: ParentViewModel
    @State private var children: [ChildModel]
    @State private var currentChild: UUID?
    @State private var selectedChild: ChildModel = ChildModel(name: "No Child")
    @State private var showPopover = false
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 100
    let gridItem = [GridItem(.adaptive(minimum: 200))]

    
    init(parentViewModel: ParentViewModel) {
        self.parentViewModel = parentViewModel
        _children = State(initialValue: parentViewModel.childdren)
    }
    var body: some View {
        
        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.11, green: 0, blue: 0.16))
                .ignoresSafeArea()
            Spacer()
            VStack(alignment: .center, spacing: 36) {
                
                ProfilesSelectView(fetch: parentViewModel.fetch, children: $parentViewModel.childdren, selectedChild: $selectedChild, imageSize: imageSize)
                
                HistoryCardView(
                    mounthData: Data(),
                    taskState: Bool(true),
                    countTasks: parentViewModel.tasksDoneInCurrentMonth,
                    goalsInProgress: parentViewModel.activePiggyBank,
                    totalCoins: Int(parentViewModel.valueOfTasksDoneInCurrentMonth),
                    piggyCoinsTrans: Int(parentViewModel.coinsInPiggyBank)
                )
                
                TaskSection(selectedChild: $selectedChild, addTask: parentViewModel.addTaskChild)
                
                Spacer()
                
                TaskRegisters(tasks: $parentViewModel.tasks)
            }
            .padding(.horizontal, 85)
            .padding(.vertical, 85)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showPopover.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color(red: 0.73, green: 0.57, blue: 0.8))
                }.popover(isPresented: $showPopover, arrowEdge: .bottom) {
                    SettingsView(selectedChild: $selectedChild)
                        .frame(minWidth: 250, minHeight: 132)
                        .background(Color(red: 0.7, green: 0.7, blue: 0.7))
                        .preferredColorScheme(.light)
                }
            }
        }
        .onAppear{
            parentViewModel.setup(modelContext: modelContext)
            parentViewModel.fetch()
        }
    }
}


//struct ToobarItemComp: View {
//    
//    @Binding var showPopover: Bool
//    @Binding var selectedChild: ChildModel
//    var action: () -> Void
//    
//    var body: some View {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    
//                }) {
//                    Image(systemName: "gearshape")
//                        .foregroundColor(Color(red: 0.73, green: 0.57, blue: 0.8))
//                }.popover(isPresented: $showPopover, arrowEdge: .bottom) {
//                    SettingsView(selectedChild: $selectedChild)
//                        .frame(minWidth: 250, minHeight: 132)
//                        .background(Color(red: 0.7, green: 0.7, blue: 0.7))
//                        .preferredColorScheme(.light)
//                }
//            }
//    }
//}

struct ProfilesSelectView: View {
    
    var fetch: (_ id: UUID) -> Void
    @Binding var children : [ChildModel]
    @Binding var selectedChild: ChildModel
    var imageSize: CGFloat
    @State var isSelected: Bool = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center) {
                ForEach(children) { child in
                    VStack(alignment: .center){
                        Button(action: {
                            fetch(child.id)
                        }) {
                            ProfileSelect(isSelected: $isSelected, imageSize: imageSize, child: child)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width / 1.2)
        }
    }
}

struct ProfileSelect: View {
    @Binding var isSelected: Bool
    var imageSize: CGFloat
    var child: ChildModel

    var body: some View {
        VStack(alignment: .center) {
            Image(child.profileImage ?? "Cat")
                .resizable()
                .scaledToFit()
                .frame(width: isSelected ? imageSize * 1.5 : imageSize,
                       height: isSelected ? imageSize * 1.5 : imageSize)
                .foregroundColor(.cyan)
                .background(
                    Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                        .offset(x: 0, y: 6)
                )
            
            Text("\(child.name)")
                .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .cornerRadius(12)
        .shadow(
            color: isSelected ? .purple : .clear,
            radius: 20, x: 0, y: 0
        )
    }
}

struct TaskSection: View {
    @Binding var selectedChild: ChildModel
    var addTask: (_ child: ChildModel, _ taskDescription: String, _ value: String, _ recurrent: Bool, _ effort: EffortTypes, _ frequency: FrequencyTypes) -> Void
    
    var body: some View {
        Text("Tasks")
            .font(Font.custom("Pally-Bold", size: 28).weight(.medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        
        TaskCreateCard(selectedChild: selectedChild, addTask: addTask)
            .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
    }
}

struct TaskRegisters: View {
    @Binding var tasks: [TaskModel]
    var body: some View {
        ForEach(tasks) { task in
            RegisterTask(task: task )
        }
    }
}


struct RegisterTask: View {
    var task: TaskModel
    var body: some View {
        VStack{
            CEffortTag(effortType: task.effort!, taskValue: task.value)
            Text(task.taskDescription)
        }
        .background(Color.gray)
    }
}

//#Preview{
//    RegisterTask()
//}
