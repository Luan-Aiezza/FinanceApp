import SwiftUI
import SwiftData

struct SelectedChild: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var historyViewModel: HistoryViewModel
    @ObservedObject var parentViewModel: ParentViewModel
    @State private var children: [ChildModel]
    
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
        
        NavigationStack {
            ZStack {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItem) {
                            HStack(spacing: 40) {
                                ForEach(children) { child in
                                    VStack {
                                        Button(action: {
                                            selectedChild = child // Atualiza a criança selecionada
                                            historyViewModel.id = child.id
                                            historyViewModel.fetch()
                                        }) {
                                            VStack {
                                                Image("iconChildGrid")
                                                    .scaledToFit()
                                                    .foregroundColor(.cyan)
                                                    .clipShape(Circle())
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
                                            .cornerRadius(12) // Define o canto arredondado da borda
                                            .shadow(color: selectedChild?.id == child.id ? .purple : .clear, radius: 20, x: 0, y: 0)
                                        }
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
                .onAppear {
                    historyViewModel.modelContext = modelContext
                    historyViewModel.fetch()
                    
                    // Se não houver uma criança selecionada, seleciona a primeira criança da lista
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
                        SettingsView(selectedChild: $selectedChild, parentViewModel: parentViewModel) // Exibe a TaskCreateView dentro do Popover
                            .frame(minWidth: 250, minHeight: 132)
                            .background(Color(red: 0.7, green: 0.7, blue: 0.7))
                            .preferredColorScheme(.light)
                    }
                }
            }
        }
    }
}
