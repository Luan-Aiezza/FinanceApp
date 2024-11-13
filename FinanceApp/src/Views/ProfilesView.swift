
import SwiftUI
import SwiftData

struct ProfilesView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject private var parentViewModel: ParentViewModel
    
    @State private var selectedChildIcon: String = "Cat" // Ícone padrão
    @State private var showChildIconSelection = false
    
    @State private var showIconSelection = false
    
    @AppStorage("selectedGuardianIcon") private var selectedGuardianIcon: String = "guardianIcon"
    @AppStorage("guardianName") private var guardianName: String = ""
    @AppStorage("password") private var password: String = ""
    
    @State private var showPasswordAlert = false
    @State private var inputPassword: String = ""
    @State private var isAuthenticated = false
    
    @State private var showLimitAlert = false
    
    @State private var childName: String = ""
    @State private var showAlert = false
    @Query private var childs: [ChildModel]
    @Query private var parents: [ParentModel]
    
    //TODO: Remover variável "thisParent" depois
    private let thisParent = ParentModel(name: "Luan")
    private let thisChild = ChildModel(name: "Rodrigo")
    
    let gridItem = [GridItem(.adaptive(minimum: 200))]
    
    init() {
        parentViewModel = .init()
    }
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Color.init(red: 0.11, green: 0, blue: 0.16)
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack {
                    Spacer(minLength: 100)
                    Text("\(guardianName) Family!")
                        .font(Font.custom("Pally-Bold", size: 48).weight(.heavy))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer(minLength: 100)
                        ForEach(parents){ parent in
                            VStack {
                                Image("Crow")
                                    .rotationEffect(.degrees(15)) // Gira a coroa em 15 graus
                                    .offset(x: 15) // Ajuste o valor de x e y para posicionar a coroa
                                
                                createProfileView(parent) // Imagem de perfil circular
                            }
                        }
                        
                        LazyVGrid(columns: gridItem){
                            Button(action: {
                                if let parent = parents.first, parent.childs.count >= 3 {
                                    // Exibe o alerta de limite se já houver 3 crianças
                                    showLimitAlert = true
                                } else {
                                    // Exibe o alerta para adicionar uma nova criança
                                    showAlert = true
                                }                            }) {
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
                                    Text("Add child")
                                        .font(
                                            Font.custom("Pally-Bold", size: 22)
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
                            }.alert("Limit reached! In this version, you can only add up to 3 children.", isPresented: $showLimitAlert) {
                                Button("OK", role: .cancel) { }
                            }
                            
                            ForEach(childs) { child in
                                createProfileView(child)
                            }
                        }
                        .position(x: UIScreen.main.bounds.width / 2.15, y: UIScreen.main.bounds.height / 6)
                    }
                    
                    //                        .padding(.top, 500)
                    Spacer()
                    
                }.padding(.horizontal, 32)
                
                
            }
        }
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
    
    
    @ViewBuilder
    private func createProfileView(_ child: ChildModel) -> some View{
        NavigationLink(destination: ProfileChildView(id: child.id)) {
            VStack{
                Image(child.profileImage ?? "Cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
                    .background(
                        Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                            .offset(x:0, y: 6)// Borda branca opcional para destaque
                    )
                    
                Text(child.name)
                    .font(
                        Font.custom("Pally-Bold", size: 22)
                            .weight(.medium)
                    )
                    .foregroundStyle(.white)
                    .scaledToFit()
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    @ViewBuilder
    private func createProfileView(_ parent: ParentModel) -> some View {
        Button(action: {
            showPasswordAlert = true
        }) {
            VStack {
                Image(selectedGuardianIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
                    .background(
                        Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                            .offset(x: 0, y: 6)
                    )
                
                
                    .gesture(
                        LongPressGesture().onEnded { _ in
                            showIconSelection = true
                        }
                    ).popover(isPresented: $showIconSelection) {
                        VStack(spacing: 20) {
                            Text("Choose an Icon")
                                .font(Font.custom("Pally-Bold", size: 24))
                                .padding()

                            HStack(spacing: 20) {
                                ForEach(["Cat", "Dog", "Tiger", "Bird"], id: \.self) { iconName in
                                    Button(action: {
                                        selectedGuardianIcon = iconName
                                        showIconSelection = false
                                    }) {
                                        Image(iconName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                    }
                                }
                            }
                            .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                    }
                Text(guardianName)
                    .font(
                        Font.custom("Pally-Bold", size: 22)
                            .weight(.medium)
                    )
                    .foregroundStyle(.white)
                    .scaledToFit()
                    .multilineTextAlignment(.center)
            }
        }
        .alert("Enter Password", isPresented: $showPasswordAlert) {
            SecureField("Password", text: $inputPassword)
                .keyboardType(.numberPad) // Limita a entrada para números
            Button("Confirm") {
                if inputPassword == password {
                    isAuthenticated = true
                } else {
                    isAuthenticated = false
                }
                inputPassword = ""
            }
            Button("Cancel", role: .cancel) {
                inputPassword = ""
            }
        }
        .navigationDestination(isPresented: $isAuthenticated) {
            SelectedChild(parentViewModel: parentViewModel)
        }
    }
    
    #Preview {
        ProfilesView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
