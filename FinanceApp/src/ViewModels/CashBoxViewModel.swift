//
//  CashBoxViewModel.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 17/10/24.
//



import SwiftUI
import SwiftData

class CashBoxViewModel: ObservableObject {
    var modelContext: ModelContext? = nil
    @Published var wallet: CashBoxModel
    @Published var goalBanks: [GoalBankModel] = []
    var cashBoxes: [CashBoxModel] = []
    @Published var child: ChildModel = ChildModel(name: "No Kid")
    @Published var goalBank: GoalBank?
    @Published var transferAmounts: [UUID: String] = [:]
    let id: UUID

    init(id: UUID) {
        self.wallet = Wallet(cashBoxDescription: "Wallet")
        self.id = id
    }
    
    @MainActor
    func fetch() {
        let goalBankDescriptor = FetchDescriptor<GoalBankModel>(sortBy: [SortDescriptor(\.creationDate)])
        let cashBoxDescriptor = FetchDescriptor<CashBoxModel>()
        let childDescriptor = FetchDescriptor<ChildModel>(sortBy: [SortDescriptor(\.name)])
        
        goalBanks = (try? (modelContext?.fetch(goalBankDescriptor) ?? [])) ?? []
        let cashBoxes = (try? (modelContext?.fetch(cashBoxDescriptor) ?? [])) ?? []
        let children = (try? (modelContext?.fetch(childDescriptor) ?? [])) ?? []
        
        child = children.first(where: { $0.id == id }) ?? ChildModel(name: "No Kid")
        
        if let wallet = child.cashBoxes.first(where: { $0.cashBoxDescription == "Wallet" }) {
            self.wallet = wallet
        } else {
            let newCashBox = CashBoxModel(cashBoxDescription: "Wallet")
            child.cashBoxes.append(newCashBox)
            modelContext?.insert(newCashBox)
            try? modelContext?.save()
        }
    }
    
    @MainActor
    func addGoal(name: String, amount: Int) {
        let cashBox = CashBoxModel(cashBoxDescription: name)
        let newGoal = GoalBankModel(goalName: name, goalAmount: amount) // Use `name` se `goalName` não existir
        newGoal.cashBox = cashBox
        
        child.goals.append(newGoal)
        modelContext?.insert(cashBox)
        modelContext?.insert(newGoal)
        try? modelContext?.save()
        fetch()
    }
    
    @MainActor
    func updateGoal(goal: GoalBankModel, name: String, amount: Int) {
        goal.cashBox.cashBoxDescription = name // Define o nome do objetivo através de `cashBoxDescription`
        goal.goalAmount = amount
        try? modelContext?.save()
        fetch() // Atualiza os dados para refletir as mudanças
    }


    
    func updateTransferAmount(for goalID: UUID, amount: String) {
        transferAmounts[goalID] = amount
    }
    
    func addCoinsToWallet(amount: Int) {
        wallet.addCoins(amount: amount)
        try? modelContext?.save()
    }
    
    @MainActor
    func addCoinsToGoal(goalID: UUID, amount: Int) {
        guard let goal = goalBanks.first(where: { $0.cashBox.id == goalID }) else { return }
        
        if amount <= wallet.coins {
            let transferAmount = min(amount, goal.goalAmount - goal.cashBox.coins)
            spendFromWallet(amount: transferAmount)
            addCoins(amount: transferAmount, goal: goal)
        } else {
            print("Saldo insuficiente na carteira.")
        }
        fetch()
    }
    
    private func addCoins(amount: Int, goal: GoalBankModel) {
        try? modelContext?.transaction {
            goal.cashBox.coins += amount
        }
    }
    
    @MainActor
    func addCoinsOnWallet(amount: Int) {
        try? modelContext?.transaction {
            wallet.coins += amount
        }
        fetch()
    }
    
    private func spendFromWallet(amount: Int) {
        try? modelContext?.transaction {
            wallet.coins -= amount
        }
    }
    
    @MainActor
    func removeGoal(goal: GoalBankModel) {
        let cashBoxToDelete = goal.cashBox
        try? modelContext?.transaction {
            modelContext?.delete(cashBoxToDelete)
            modelContext?.delete(goal)
        }
        fetch()
    }
}
