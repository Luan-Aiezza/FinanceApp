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
    
    var body: some View {
        //PRIMEIRA CAMADA
        NavigationStack {
            ZStack{
                Image("GreenBackground")
                    .resizable()
                    .ignoresSafeArea()
                //SEGUNDA CAMADA
                VStack{
                    Text("FINANCE APP")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    Spacer()
                    HStack{
                        ForEach(parents){ parent in
                            createProfileView(parent)
                        }
                        ForEach(childs) { child in
                            createProfileView(child)
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear{
            if let _ = parents.first{
                return
            }else {
                modelContext.insert(thisParent)
            }
            if let _ = childs.first{
                return
            }else {
                modelContext.insert(thisChild)
            }
        }
    }
    
    
    @ViewBuilder
    private func createProfileView(_ child: ChildModel) -> some View{
        NavigationLink(destination: ProfileChildView(id: child.id)) {
            VStack{
                Text("Perfil de \(child.name)")
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func createProfileView(_ parent: ParentModel) -> some View{
        NavigationLink(destination: ProfileParentView()) {
            VStack{
                Text("Perfil de \(parent.name)")
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.cyan)
            }
        }
        .padding()
    }
}

#Preview {
    ProfilesView()
        .modelContainer(for: Item.self, inMemory: true)
}
