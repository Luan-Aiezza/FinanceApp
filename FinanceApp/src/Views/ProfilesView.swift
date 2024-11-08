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
    
    @State private var childName: String = ""
    @State private var showWarning = false
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
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridItem){
                            ForEach(parents){ parent in
                                createProfileView(parent)
                            }
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
                        .position(x: UIScreen.main.bounds.width / 2.15, y: UIScreen.main.bounds.height / 2)
                    }
                   
//                        .padding(.top, 500)
                    Spacer()
                    Button(action: {
                                showWarning = true
                            }) {
                                Text("Remove last added child")
                                    .foregroundStyle(Color.red)
                            }
                            .alert("Confirm", isPresented: $showWarning) {
                                Button("Remove", role: .destructive) {
                                    deleteChild()
                                    parentViewModel.fetch()
                                }
                                Button("Cancel", role: .cancel) {}
                            } message: {
                                Text("Are you sure you want to remove the last added child?")
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
