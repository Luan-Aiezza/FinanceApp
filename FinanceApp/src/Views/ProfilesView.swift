//
//  ContentView.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import SwiftUI
import SwiftData

struct ProfilesView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject private var parentViewModel: ParentViewModel
    
    @State private var showWarning = false
    
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
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridItem){
                            ForEach(parents){ parent in
                                createProfileView(parent)
                            }
                            ForEach(childs) { child in
                                createProfileView(child)
                            }
                            Button(action:{
                                if let parent = parents.first{
                                    let newChild = ChildModel(name: "Child")
                                    parent.childs.append(newChild)
                                    modelContext.insert(newChild)
                                    try! modelContext.save()
                                }}){
                                    VStack {
                                        Image("Add Profile")
                                            .frame(width: 150, height: 150)
                                            .aspectRatio(contentMode: .fill)
                                            .background(Color.white) // Fundo branco do círculo
                                            .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                                            .overlay(
                                                Circle().stroke(Color.white, lineWidth: 4) // Borda branca opcional para destaque
                                            )
                                            .shadow(radius: 5) // Sombra opcional para efeito
                                        Text("Add profile")
                                            .font(
                                                Font.custom("Pally-Bold", size: 17)
                                                    .weight(.medium)
                                            )
                                            .foregroundStyle(.white)
                                    }
                                }
                        }
                        .position(x: UIScreen.main.bounds.width / 2.15, y: UIScreen.main.bounds.height / 2)
                    }
                   
//                        .padding(.top, 500)
                    Spacer()
                    Button(action: {
                                showWarning = true
                            }) {
                                Text("Remover último filho adicionado")
                                    .foregroundStyle(Color.red)
                            }
                            .alert("Confirmação", isPresented: $showWarning) {
                                Button("Remover", role: .destructive) {
                                    deleteChild()
                                }
                                Button("Cancelar", role: .cancel) {}
                            } message: {
                                Text("Tem certeza de que deseja remover o último filho adicionado?")
                            }
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
                Image("childIcon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
                    .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                    .background(
                        Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                            .offset(x:0, y: 6)// Borda branca opcional para destaque
                    )
                Text(child.name)
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    private func createProfileView(_ parent: ParentModel) -> some View{
        NavigationLink(destination: SelectedChild(parentViewModel: parentViewModel)) {
            VStack{
                Image("guardianIcon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
                    .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                    .background(
                        Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                            .offset(x:0, y: 6)// Borda branca opcional para destaque
                    )
                Text("Guardian")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundStyle(.white)
            }
        }
    }
    
    func deleteChild(){
        if let delete = childs.first{
            modelContext.delete(delete)
        }
        childs.forEach(){ child in
            print(child.name)
        }
        try! modelContext.save()
    }
    
}

#Preview {
    ProfilesView()
        .modelContainer(for: Item.self, inMemory: true)
}
