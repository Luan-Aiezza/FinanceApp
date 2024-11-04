//
//  Card.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import SwiftUI
import SwiftData

struct TaskBoard: View {
    
    //    var tasks: [TaskModel]
    
    @Environment(\.modelContext) private var modelContext
    @Query private var childs: [ChildModel]
    let id: UUID
    @ObservedObject private var cashViewModel: CashBoxViewModel
    init(id: UUID) {
        self.cashViewModel = .init(id: id)
        self.id = id
    }
    let gridItem = [GridItem(.adaptive(minimum: 300))]
    
    var body: some View {
        if let tasks = childs.first(where:{$0.id == id})?.tasks {
            VStack(spacing: 32){
                Text("Your tasks for today!")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .font(
                        Font.custom("Pally-Bold", size: 24)
                            .weight(.medium)
                    )
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color(red: 0.36, green: 0, blue: 0.55))
                    .clipShape(.rect(cornerRadius: 24.0))
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.25, green: 0, blue: 0.39))
                            .offset(x:0, y: 6)
                    )
                ScrollView(.vertical) {
                    LazyVGrid(columns: gridItem, spacing: 40) {
                        ForEach(tasks) { actualTask in
                            //                            NewTaskCard(taskID: task.persistentModelID)
                            TaskCard(cashViewModel: cashViewModel, taskID: actualTask.persistentModelID)
                                .onChange(of: actualTask.isDone){
                                    try! modelContext.save()
                                }
                        }
                    }.padding(.horizontal, 80)
                }
                
            }
            .onAppear{
                cashViewModel.modelContext = modelContext
                cashViewModel.fetch()
            }
        }
    }
}

