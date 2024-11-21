import SwiftUI
import SwiftData

struct SelectedChild: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var parentViewModel: ParentViewModel
    @State private var selectedChild: ChildModel = ChildModel(name: "No Child")
    @State private var showPopover = false
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 100
    @Environment(\.sizeCategory) var sizeCategory  // Observa o tamanho do Dynamic Type
        
    let gridItem = [GridItem(.adaptive(minimum: 200))]

    init(parentViewModel: ParentViewModel) {
        self.parentViewModel = parentViewModel
    }

    var body: some View {
        let content = VStack(alignment: .center, spacing: 36) {
            ProfilesSelectView(parentViewModel: parentViewModel, fetch: parentViewModel.fetch, children: $parentViewModel.childdren, selectedChild: $selectedChild, imageSize: imageSize)

            HistoryCardView(
                mounthData: Data(),
                taskState: Bool(true),
                countTasks: parentViewModel.tasksDoneInCurrentMonth,
                goalsInProgress: parentViewModel.activePiggyBank,
                totalCoins: Int(parentViewModel.valueOfTasksDoneInCurrentMonth),
                piggyCoinsTrans: Int(parentViewModel.coinsInPiggyBank)
            )

            TaskSection(selectedChild: $selectedChild, addTask: parentViewModel.addTaskChild)
            TaskRegisters(tasks: $parentViewModel.tasks)
        }
        .padding(.horizontal, 85)
        .padding(.vertical, 32)

        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.11, green: 0, blue: 0.16))
                .ignoresSafeArea()
            Spacer()

            if sizeCategory > .extraExtraLarge {  // Verifica se o Dynamic Type está em tamanho grande
                ScrollView {
                    content
                }
            } else {
                content
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showPopover.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color(red: 0.73, green: 0.57, blue: 0.8))
                }
                .popover(isPresented: $showPopover, arrowEdge: .bottom) {
                    SettingsView(updateChildProfile: parentViewModel.upDateChildProfile, deleteChildProfile: parentViewModel.deleteChildProfile, selectedChild: $selectedChild)
                        .frame(minWidth: 250, minHeight: 132)
                        .background(Color.white)
                        .preferredColorScheme(.light)
                        
                }
            }
        }
        .onAppear {
            parentViewModel.setup(modelContext: modelContext)
            parentViewModel.fetch()
        }
        .onChange(of: parentViewModel.isChangeTaskDone) {
            parentViewModel.fetch(id: parentViewModel.currentChild)
        }
    }
}


struct ProfilesSelectView: View {
    
    @ObservedObject var parentViewModel: ParentViewModel
    
    var fetch: (_ id: UUID) -> Void
    @Binding var children: [ChildModel]
    @Binding var selectedChild: ChildModel
    
    var imageSize: CGFloat

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center) {
                ForEach(children) { child in
                    VStack(alignment: .center) {
                        Button(action: {
                            fetch(child.id) // Seleciona o filho
                            parentViewModel.currentChild = child.id
                            selectedChild = child // Atualiza o filho selecionado
                        }) {
                            ProfileSelect(imageSize: imageSize, child: child, isSelected: selectedChild.id == child.id)
                        }
                    }
                }
            }
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width / 1.2)
        }
        .onAppear {
            // Define o primeiro filho como selecionado por padrão
            if let firstChild = children.first {
                selectedChild = firstChild
                fetch(firstChild.id) // Chama a função para buscar as informações do primeiro filho
            }
        }
    }
}

struct ProfileSelect: View {
    var imageSize: CGFloat
    var child: ChildModel
    var isSelected: Bool // Agora recebemos se o ícone está selecionado diretamente

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
            color: isSelected ? .purple : .clear, // Sombra visível somente quando selecionado
            radius: 20, x: 0, y: 0
        )
    }
}
