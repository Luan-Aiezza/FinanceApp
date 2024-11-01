//
//  CashBoxViewModel.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 17/10/24.
//



import SwiftUI

class CashBoxViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Published var wallet: Wallet
    @Published var goalBanks: [GoalBank] = []
    @Published var goalBank: GoalBank?
    @Published var transferAmounts: [UUID: String] = [:] // Mudança para usar `goalID` como chave

    
    init() {
        self.wallet = Wallet(cashBoxDescription: "Wallet")
    }
    
    // Atualiza o valor de transferência para uma meta
    func updateTransferAmount(for goalID: UUID, amount: String) {
           transferAmounts[goalID] = amount
       }
    
    // Método para adicionar uma nova meta de poupança
    func addGoal(name: String, amount: Int) {
        let newGoal = GoalBank(goalName: name, goalAmount: amount)
        goalBanks.append(newGoal)
        modelContext.insert(newGoal)
        try? modelContext.save()
    }
    
    // Adiciona moedas à carteira
    func addCoinsToWallet(amount: Int) {
        wallet.addCoins(amount: amount)
        try? modelContext.save()
    }
    
    // Gasta moedas da carteira
    func spendCoinsFromWallet(amount: Int) {
        wallet.spendCoins(amount: amount)
        try? modelContext.save()
    }
    
    // Adiciona moedas a uma meta
    func addCoinsToGoal(goalID: UUID, amount: Int) {
            guard let goal = goalBanks.first(where: { $0.goalID == goalID }) else { return }
            
            // Verifica se há moedas suficientes na carteira
            if amount <= wallet.coins {
                let transferAmount = min(amount, goal.goalAmount - goal.coins) // Limita a transferência ao valor necessário
                wallet.spendCoins(amount: transferAmount) // Diminui as moedas da carteira
                goal.addCoins(amount: transferAmount) // Adiciona as moedas na meta
                
                try? modelContext.save() // Salva as mudanças no contexto de dados
            } else {
                print("Saldo insuficiente na carteira.")
            }
        }
    
    // Verifica se o valor de transferência é válido
    func isTransferAmountValid(goalID: UUID) -> Bool {
            guard let amountString = transferAmounts[goalID],
                  let amount = Int(amountString),
                  let goal = goalBanks.first(where: { $0.goalID == goalID }) else { return false }
            
            let remainingAmount = goal.goalAmount - goal.coins
            return amount > 0 && amount <= wallet.coins && amount <= remainingAmount
        }
    
    // Remove uma meta
    func removeGoal(goalID: UUID) {
            goalBanks.removeAll(where: { $0.goalID == goalID })
            try? modelContext.save()
        }
    
    // Remove moedas de uma meta e as retorna para a carteira
    func removeCoinsFromGoal(goalName: String, amount: Int) {
        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
            print("Meta não encontrada")
            return
        }
        goal.spendCoins(amount: amount)
        wallet.addCoins(amount: amount)
        try? modelContext.save()
    }
}
