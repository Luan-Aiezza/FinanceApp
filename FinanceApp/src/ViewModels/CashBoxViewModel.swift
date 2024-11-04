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
    @Published var transferAmounts: [UUID: String] = [:] // Mudança para usar `goalID` como chave
    let id: UUID
    
    
    init(id: UUID) {
        self.wallet = Wallet(cashBoxDescription: "Wallet")
        self.id = id
    }
    @MainActor
    func fetch(){
        do {
            let goalBankDescriptor = FetchDescriptor<GoalBankModel>(sortBy: [SortDescriptor(\.creationDate)])
            
            let cashBoxDescriptor = FetchDescriptor<CashBoxModel>()
            
            let childDescriptor = FetchDescriptor<ChildModel>(sortBy: [SortDescriptor(\.name)])
            
            goalBanks = (try? (modelContext?.fetch(goalBankDescriptor) ?? [])) ?? []
            let cashBoxes = (try? (modelContext?.fetch(cashBoxDescriptor) ?? [])) ?? []
            let children = (try? (modelContext?.fetch(childDescriptor) ?? [])) ?? []
            child = children.first(where: {$0.id == id}) ?? ChildModel(name: "No Kid")
            if let wallet = child.cashBoxes.first(where: {$0.cashBoxDescription == "Wallet"}) {
                self.wallet = wallet
            } else {
                let newCashBox = CashBoxModel(cashBoxDescription: "Wallet")
                child.cashBoxes.append(newCashBox)
                modelContext?.insert(newCashBox)
                try? modelContext?.save()
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    @MainActor func addGoal(name: String, amount: Int) {
        let cashBox = CashBoxModel(cashBoxDescription: name)
        let newGoal = GoalBankModel(goalName: name, goalAmount: amount)
        newGoal.cashBox = cashBox

        child.goals.append(newGoal)    
        modelContext?.insert(cashBox)
        modelContext?.insert(newGoal)
        try? modelContext?.save()
        fetch()
    }
    
    // Atualiza o valor de transferência para uma meta
    func updateTransferAmount(for goalID: UUID, amount: String) {
        transferAmounts[goalID] = amount
    }
    
    // Método para adicionar uma nova meta de poupança
    
    // Adiciona moedas à carteira
    func addCoinsToWallet(amount: Int) {
        wallet.addCoins(amount: amount)
        try? modelContext?.save()
    }
    
    // Gasta moedas da carteira
//    func spendCoinsFromWallet(amount: Int) {
//        wallet.spendCoins(amount: amount)
//        try? modelContext.save()
//    }
//    
//    // Adiciona moedas a uma meta
    @MainActor func addCoinsToGoal(goalID: UUID, amount: Int) {
        guard let goal = goalBanks.first(where: { $0.cashBox.id == goalID }) else { return }
            
            // Verifica se há moedas suficientes na carteira
            if amount <= wallet.coins {
                let transferAmount = min(amount, goal.goalAmount - goal.cashBox.coins) // Limita a transferência ao valor necessário
                spendFromWallet(amount: transferAmount) // Diminui as moedas da carteira
                addCoins(amount: transferAmount, goal: goal) // Adiciona as moedas na meta
                
//                try? modelContext?.save() // Salva as mudanças no contexto de dados
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
    
    @MainActor func addCoinsOnWallet(amount: Int) {
        try? modelContext?.transaction {
         wallet.coins += amount
        }
        fetch()
    }
    
    private func spendFromWallet(amount: Int){
        try? modelContext?.transaction {
            wallet.coins -= amount
        }
    }

    func removeGoal(goalID: UUID) {
        if let goalIndex = goalBanks.firstIndex(where: { $0.cashBox.id == goalID }) {
            let goal = goalBanks[goalIndex]
            goalBanks.remove(at: goalIndex)
            
            // Remove a meta e seu CashBox do contexto
            modelContext?.delete(goal)
            modelContext?.delete(goal.cashBox)
            try? modelContext?.save()
        }
    }

    
//    // Verifica se o valor de transferência é válido
//    func isTransferAmountValid(goalID: UUID) -> Bool {
//            guard let amountString = transferAmounts[goalID],
//                  let amount = Int(amountString),
//                  let goal = goalBanks.first(where: { $0.goalID == goalID }) else { return false }
//            
//            let remainingAmount = goal.goalAmount - goal.coins
//            return amount > 0 && amount <= wallet.coins && amount <= remainingAmount
//        }
//    
//    // Remove uma meta
//    func removeGoal(goalID: UUID) {
//            goalBanks.removeAll(where: { $0.goalID == goalID })
//            try? modelContext.save()
//        }
//    
//    // Remove moedas de uma meta e as retorna para a carteira
//    func removeCoinsFromGoal(goalName: String, amount: Int) {
//        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
//            print("Meta não encontrada")
//            return
//        }
//        goal.spendCoins(amount: amount)
//        wallet.addCoins(amount: amount)
//        try? modelContext.save()
//    }
}
