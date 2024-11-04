//
//  CashBoxViewModel.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 17/10/24.
//



import SwiftUI
import SwiftData

class HistoryViewModel: ObservableObject {
    var modelContext: ModelContext? = nil
    var cashBoxes: [CashBoxModel] = []
    @Published var child: ChildModel = ChildModel(name: "No Kid")
    let id: UUID
    
    @Published var activePiggyBank: Int = 0
    @Published var coinsInPiggyBank: Int = 0
    @Published var tasksDoneInCurrentMonth: Int = 0
    @Published var valueOfTasksDoneInCurrentMonth: Int = 0
    
    init(id: UUID) {
        self.id = id
    }
    @MainActor
    func fetch(){
        do {
            let childDescriptor = FetchDescriptor<ChildModel>(sortBy: [SortDescriptor(\.name)])
            let children = (try? (modelContext?.fetch(childDescriptor) ?? [])) ?? []
            child = children.first(where: {$0.id == id}) ?? ChildModel(name: "No Kid")
//            if let wallet = child.cashBoxes.first(where: {$0.cashBoxDescription == "Wallet"}) {
//            } else {
//                let newCashBox = CashBoxModel(cashBoxDescription: "Wallet")
//                child.cashBoxes.append(newCashBox)
//                modelContext?.insert(newCashBox)
//                try? modelContext?.save()
//            }
            activePiggyBank = countActivePiggyBank(child: child)
            coinsInPiggyBank = countCoinsInPiggyBanks(child: child)
            tasksDoneInCurrentMonth = countTaskDoneInMonth(tasks: taskDoneInMonth(child: child))
            valueOfTasksDoneInCurrentMonth = valueOfCoinsInMonth(tasks: taskDoneInMonth(child: child))
            
        } catch {
            print("Fetch failed")
        }
        
    }
    
    private func countActivePiggyBank(child: ChildModel) -> Int {
        let activePiggyBanks = child.goals.count(where: {$0.finishDate != nil})
        return activePiggyBanks
    }

    private func countCoinsInPiggyBanks(child: ChildModel) -> Int {
        let coinsInPiggyBanks = child.goals.reduce(0) {
            $0 + $1.cashBox.coins
        }
        return coinsInPiggyBanks
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
    
    private func countTaskDoneInMonth(tasks: [TaskModel]) -> Int {
        return tasks.count
    }
    
    private func valueOfCoinsInMonth(tasks: [TaskModel]) -> Int {
        let valueOfCoins = tasks.reduce(0) {
            $0 + $1.value
        }
        return Int(valueOfCoins)
    }
    
}
