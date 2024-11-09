//
//  TestCashBoxViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 08/11/24.
//

import SwiftUI
import SwiftData

class TestCashBoxViewModel: ObservableObject {
    
    private var id: UUID
    private var parentService: Service<ParentModel>? = nil
    private var childService: Service<ChildModel>? = nil
    private var taskService: Service<TaskModel>? = nil
    private var goalService: Service<GoalBankModel>? = nil
    private var cashBoxService: Service<CashBoxModel>? = nil
    
    @Published var parent: ParentModel?
    @Published var wallet: CashBoxModel?
    @Published var goals: [GoalBankModel]?
    
    init(id: UUID) {
        self.id = id
    }
    
    func setup(modelContext: ModelContext){
        parentService = .init(modelContext: modelContext)
        childService = .init(modelContext: modelContext)
        taskService = .init(modelContext: modelContext)
        goalService = .init(modelContext: modelContext)
        cashBoxService = .init(modelContext: modelContext)
    }
    
    func fetch(){
        let parents = parentService?.read()
        parent = parents?.first
        if let child = parent?.childs.first(where: {$0.id == id}){
            wallet = child.cashBoxes.first(where: {$0.cashBoxDescription == "Wallet"})
            let goals = child.goals
        }
        
        
    }
}
