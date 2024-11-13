import SwiftUI
import SwiftData

struct SelectedChild: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var historyViewModel: HistoryViewModel
    @ObservedObject var parentViewModel: ParentViewModel
    @State private var children: [ChildModel]
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 100
    
    init(parentViewModel: ParentViewModel) {
        self.historyViewModel = .init(id: parentViewModel.firstChildId ?? UUID())
        self.parentViewModel = parentViewModel
        _children = State(initialValue: parentViewModel.childdren ?? [])
    }
    
    @State private var currentChild: UUID?
    @State private var selectedChild: ChildModel?
    @State private var showPopover = false
    
    let gridItem = [GridItem(.adaptive(minimum: 200))]
    
    var body: some View {
        
        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.11, green: 0, blue: 0.16))
                .ignoresSafeArea()
            Spacer()
            VStack(alignment: .center, spacing: 36) {
                ScrollView(.horizontal) {
                    HStack(alignment: .center) {
                        ForEach(children) { child in
                            let isSelected = selectedChild?.id == child.id
                            VStack(alignment: .center){
                                Button(action: {
                                    selectedChild = child
                                    historyViewModel.id = child.id
                                    historyViewModel.fetch()
                                }) {
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
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2)
                }
                
                HistoryCardView(
                    mounthData: Data(),
                    taskState: Bool(true),
                    countTasks: historyViewModel.tasksDoneInCurrentMonth,
                    goalsInProgress: historyViewModel.activePiggyBank,
                    totalCoins: Int(historyViewModel.valueOfTasksDoneInCurrentMonth),
                    piggyCoinsTrans: Int(historyViewModel.coinsInPiggyBank)
                )
                
                Text("Tasks")
                    .font(Font.custom("Pally-Bold", size: 28).weight(.medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                TaskCreateCard(selectedChild: selectedChild)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                
                Spacer()
            }
            .padding(.horizontal, 85)
            .padding(.vertical, 85)
            .onAppear {
                historyViewModel.modelContext = modelContext
                historyViewModel.fetch()
                
                if selectedChild == nil, let firstChild = children.first {
                    selectedChild = firstChild
                    historyViewModel.id = firstChild.id
                    historyViewModel.fetch()
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showPopover.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color(red: 0.73, green: 0.57, blue: 0.8))
                }.popover(isPresented: $showPopover, arrowEdge: .bottom) {
                    SettingsView(selectedChild: $selectedChild, parentViewModel: parentViewModel)
                        .frame(minWidth: 250, minHeight: 132)
                        .background(Color(red: 0.7, green: 0.7, blue: 0.7))
                        .preferredColorScheme(.light)
                }
            }
        }
    }
}
