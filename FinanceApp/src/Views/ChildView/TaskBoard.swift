//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI
import SwiftData

struct TaskBoard: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var childs: [ChildModel]
    let id: UUID
    @ObservedObject private var cashViewModel: CashBoxViewModel
    @ScaledMetric(relativeTo: .body) var dynamicSpacing: CGFloat = 32 // Ajusta o espaçamento com base no Dynamic Type
//    @ScaledMetric(relativeTo: .largeTitle) var dynamicPadding: CGFloat = 16
    
    init(id: UUID) {
        self.cashViewModel = .init(id: id)
        self.id = id
    }
    
    let gridItem = [GridItem(.adaptive(minimum: 300))]
    
    var body: some View {
        if let tasks = childs.first(where:{$0.id == id})?.tasks {
            VStack(spacing: dynamicSpacing) { // Usa o valor dinâmico para o espaçamento
                Text("Your tasks for today!")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .font(
                        Font.custom("Pally-Bold", size: 24)
                            .weight(.medium)
                    )
                    .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color(red: 0.36, green: 0, blue: 0.55))
                    .clipShape(.rect(cornerRadius: 24.0))

                ScrollView(.vertical) {
                    LazyVGrid(columns: gridItem, spacing: dynamicSpacing) { // Aplica o espaçamento dinâmico na grid
                        ForEach(tasks) { actualTask in
                            TaskCard(cashViewModel: cashViewModel, taskID: actualTask.persistentModelID)
                                .onChange(of: actualTask.isDone){
                                    try! modelContext.save()
                                }
                        }
                    }
                }
            }
            .onAppear{
                cashViewModel.modelContext = modelContext
                cashViewModel.fetch()
            }
        }
    }
}
