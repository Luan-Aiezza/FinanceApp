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
    
    @Query private var childs: [ChildModel]
    @Query private var parents: [ParentModel]
    
    //TODO: Remover variável "thisParent" depois
    private let thisParent = ParentModel(name: "Luan")
    private let thisChild = ChildModel(name: "Rodrigo")
    
    let gridItem = [GridItem(.adaptive(minimum: 200))]
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack(){
                    ScrollView(.vertical) {
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
                                            .fontWeight(.heavy)
                                            .foregroundStyle(.white)
                                    }
                                }
                        }
                    }.padding(.horizontal, 32)
                        .padding(.top, 500)
                    Spacer()
                    Button(action: deleteChild){
                        Text("Remover ultimo filho adicionado")
                            .foregroundStyle(.effortMedium)
                    }
                }.padding(.horizontal, 32)
                
                
            }
        }
        .onAppear{
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
                    .overlay(
                        Circle().stroke(Color.purple, lineWidth: 4) // Borda branca opcional para destaque
                    )
                Text(child.name)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    private func createProfileView(_ parent: ParentModel) -> some View{
        NavigationLink(destination: SelectedChild(id: parent.id)) {
            VStack{
                Image("guardianIcon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
                    .clipShape(Circle()) // Faz a imagem ficar dentro de um círculo
                    .overlay(
                        Circle().stroke(Color.purple, lineWidth: 4) // Borda branca opcional para destaque
                    )
                Text("Guardian")
                    .fontWeight(.heavy)
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
