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
    @Published var goals: [GoalBankModel] = []
    @Published var child: ChildModel?
    
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
            self.child = child
            self.wallet = child.cashBoxes.first(where: {$0.cashBoxDescription == "Wallet"})
            goals = child.goals
        }
    }
    
    func addGoal(name: String, amount: Int){
        let newCashBox = CashBoxModel(cashBoxDescription: name)
        let newGoal = GoalBankModel(goalName: name, goalAmount: amount)
        
        newGoal.cashBox = newCashBox
        if let childService = childService,
           let cashBoxService = cashBoxService,
           let goalService = goalService,
           let parentService = parentService,
           let child = child,
           let parent = parent {
            let _ = childService.update(child) { child in
                child.goals.append(newGoal)
                let _ = parentService.update(parent) { parent in
                    if let index = parent.childs.firstIndex(where: {$0.id == child.id}){
                        parent.childs[index] = child
                    }
                }
            }
            let _ = goalService.create(newGoal)
            let _ = cashBoxService.create(newCashBox)
        }
        fetch()
        
    }
    
    func addCoinsToGoal(goalID: UUID, amount: Int){
        if let goal = goals.first(where: {$0.cashBox.id == goalID}),
           let wallet = wallet,
           let childService = childService,
           let cashBoxService = cashBoxService,
           let goalService = goalService,
           let parentService = parentService,
           let child = child,
           let parent = parent{
            
            if amount <= wallet.coins {
                let _ = goalService.update(goal) { goal in
                    let _ = cashBoxService.update(wallet){ wallet in
                        wallet.coins -= amount
                        goal.cashBox.coins += amount
                        let _ = childService.update(child) { child in
                            if let walletIndex = child.cashBoxes.firstIndex(where: {$0.cashBoxDescription == "Wallet"}),
                               let goalIndex = child.cashBoxes.firstIndex(where: {$0.id == goal.cashBox.id}){
                                child.cashBoxes[walletIndex] = wallet
                                child.goals[goalIndex] = goal
                            }
                            let _ = parentService.update(parent) { parent in
                                if let childIndex = parent.childs.firstIndex(where: {$0.id == child.id}){
                                    parent.childs[childIndex] = child
                                }
                            }
                            
                        }
                    }
                    
                }
            }
            else{
                print("Not enough coins or other error occurred")
            }
        }
        fetch()
    }
    
}
