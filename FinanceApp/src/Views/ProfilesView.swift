
import SwiftUI
import SwiftData

struct ProfilesView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject private var parentViewModel: ParentViewModel
    
    @State private var childName: String = ""
    @State private var showAlert = false
    @Query private var childs: [ChildModel]
    @Query private var parents: [ParentModel]
    
    @ObservedObject private var navigation = AppNavigation.shared
    
    //TODO: Remover variável "thisParent" depois
    private let thisParent = ParentModel(name: "Luan")
    private let thisChild = ChildModel(name: "Rodrigo")
    
    let gridItem = [GridItem(.adaptive(minimum: 200))]
    
    init() {
        parentViewModel = .init()
    }
    
    var body: some View {
        //PRIMEIRA CAMADA
//        NavigationStack(path: $path) {
            ZStack{
                Color.init(red: 0.11, green: 0, blue: 0.16)
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack {
                    Spacer(minLength: 100)
                    Text("Coinc")
                        .font(Font.custom("Pally-Bold", size: 48).weight(.heavy))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer(minLength: 100)
                        ForEach(parents){ parent in
                            createProfileView(parent)
                        }
                        Spacer()
                        LazyVGrid(columns: gridItem){
                            ForEach(childs) { child in
                                createProfileView(child)
                            }
                            Button(action: {
                                showAlert = true
                            }) {
                                VStack {
                                    Image("Add Profile")
                                        .frame(width: 150, height: 150)
                                        .aspectRatio(contentMode: .fill)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 4)
                                        )
                                        .shadow(radius: 5)
                                    Text("Add profile")
                                        .font(
                                            Font.custom("Pally-Bold", size: 17)
                                                .weight(.medium)
                                        )
                                        .foregroundStyle(.white)
                                }
                            }
                            .alert("Enter Child's Name", isPresented: $showAlert) {
                                TextField("Child's name", text: $childName)
                                Button("Create") {
                                    if let parent = parents.first {
                                        let newChild = ChildModel(name: childName)
                                        parent.childs.append(newChild)
                                        modelContext.insert(newChild)
                                        parentViewModel.fetch()
                                        try? modelContext.save()
                                    }
                                    childName = "" // Limpa o campo após a criação
                                }
                                Button("Cancel", role: .cancel) {
                                    childName = ""
                                }
                            }
                        }
                        .position(x: UIScreen.main.bounds.width / 2.15, y: UIScreen.main.bounds.height / 6)
                    }
                    
                    //                        .padding(.top, 500)
                    Spacer()
                    
                }.padding(.horizontal, 32)
                
                
            }
            .navigationDestination(for: ChildModel.self, destination: { child in
                TestProfileChildView(id: child.id)
            })
            .tint(Color(red: 0.73, green: 0.57, blue: 0.8))
            .onAppear{
                parentViewModel.modelContext = modelContext
                parentViewModel.fetch()
                
                if let _ = parents.first{
                    return
                }else {
                    modelContext.insert(thisParent)
                }
                try! modelContext.save()
            }
        }
        
//    }
        @ViewBuilder
        private func createProfileView(_ child: ChildModel) -> some View{
            Button(action: {
                navigation.navigateTo(to: .childProfile(id: child.id))
            }){
                VStack{
                    Image("childIcon")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.cyan)
                        .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                        .background(
                            Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                .offset(x:0, y: 6)// Borda branca opcional para destaque
                        )
                        .scaledToFit()
                    Text(child.name)
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                        .foregroundStyle(.white)
                        .scaledToFit()
                }
            }
        }
        
        @ViewBuilder
        private func createProfileView(_ parent: ParentModel) -> some View{
            NavigationLink(destination: SelectedChild(parentViewModel: parentViewModel)) {
                VStack{
                    //Image("Property 1=b1")
                    Image("guardianIcon")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.cyan)
                        .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                        .background(
                            Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                .offset(x:0, y: 6)// Borda branca opcional para destaque
                        )
                        .scaledToFit()
                    Text("Guardian")
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                        .foregroundStyle(.white)
                        .scaledToFit()
                }
            }
        }
        
    }
    
    #Preview {
        ProfilesView()
            .modelContainer(for: Item.self, inMemory: true)
    }
