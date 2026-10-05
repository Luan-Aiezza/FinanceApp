//
//  TestHistoryViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 08/11/24.
//

import SwiftUI
import SwiftData

class TestHistoryViewModel: ObservableObject {
    private let id: UUID
    var parent: ParentModel?
    @Published var child: ChildModel?
    
    init(id: UUID){
        self.id = id
    }
    
    @Published var activePiggyBank: Int = 0
    @Published var coinsInPiggyBank: Int = 0
    @Published var tasksDoneInCurrentMonth: Int = 0
    @Published var valueOfTasksDoneInCurrentMonth: Int = 0
    
    private var parentService: Service<ParentModel>? = nil
    
    func setup(modelContext: ModelContext){
        parentService = . init(modelContext: modelContext)
    }
    
    func fetch(){
        let parents = parentService?.read()
        parent = parents?.first
        if let parent = parent {
            child = parent.childs.first(where: {$0.id == id})
            if let child = child {
                activePiggyBank = countActivePiggyBank(child: child)
                
                coinsInPiggyBank = countCoinsInPiggyBanks(child: child)
                
                let tasksDoneInMonth = taskDoneInMonth(child: child)
                
                tasksDoneInCurrentMonth = countTaskDoneInMonth(tasks: tasksDoneInMonth)
                
                valueOfTasksDoneInCurrentMonth = valueOfCoinsInMonth(tasks: tasksDoneInMonth)
                
            }
        }
    }
    
    private func countActivePiggyBank(child: ChildModel) -> Int {
        let activePiggyBanks = child.goals.count(where: {$0.finishDate == nil})
        return activePiggyBanks
    }
    
    private func countCoinsInPiggyBanks(child: ChildModel) -> Int {
        let coinsInPiggyBanks = child.goals.reduce(0) {
            $0 + $1.cashBox.coins
        }
        return coinsInPiggyBanks
    }
    
    private func valueOfCoinsInMonth(tasks: [TaskModel]) -> Int {
        let valueOfCoins = tasks.reduce(0) {
            $0 + $1.value
        }
        return Int(valueOfCoins)
    }
    
    private func countTaskDoneInMonth(tasks: [TaskModel]) -> Int {
        return tasks.count
    }
    
    private func taskDoneInMonth(child: ChildModel) -> [TaskModel] {
        let countComplete = child.tasks.filter{ task in
            guard task.isDone else { return false }
                let calendar = Calendar.current
                let month = calendar.component(.month, from: Date())
                let year = calendar.component(.year, from: Date())
            if let finishDate = task.finishDate {
                    let taskMonth = calendar.component(.month, from: finishDate)
                    let taskYear = calendar.component(.year, from: finishDate)
                    return taskMonth == month && taskYear == year
                }
                
                return month == month && year == year
        }
        return countComplete
    }
}
