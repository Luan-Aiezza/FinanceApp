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
    @Query private var items: [Item]

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
                        // Botão com imagem
                        NavigationLink(destination: ProfileChildView()) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.cyan)
                        }
                        .padding()
                        NavigationLink(destination: ProfileParentView()) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.yellow)
                        }
                        .padding()
                        
                    }
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    ProfilesView()
        .modelContainer(for: Item.self, inMemory: true)
}
