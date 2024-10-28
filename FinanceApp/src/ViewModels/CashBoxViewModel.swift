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
    @Published var transferAmounts: [String: String] = [:] // Adicionando um dicionário para armazenar o valor para cada meta
    init() {
        self.wallet = Wallet()
    }
    func updateTransferAmount(for goalName: String, amount: String) {
            transferAmounts[goalName] = amount
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
    
    
    
    func addCoinsToGoal(goalName: String, amount: Int) {
            if let index = goalBanks.firstIndex(where: { $0.goalName == goalName }) {
                guard amount <= wallet.coins else { return }
                
                let remainingAmount = goalBanks[index].goalAmount - goalBanks[index].coins
                let transferAmount = min(amount, remainingAmount)
                
                wallet.coins -= transferAmount
                goalBanks[index].coins += transferAmount
                
                if goalBanks[index].coins >= goalBanks[index].goalAmount {
                    goalBanks[index].goalAchievedDate = Date()
                }
            }
        }
    func isTransferAmountValid(goalName: String) -> Bool {
            if let amountString = transferAmounts[goalName],
               let amount = Int(amountString),
               let goal = goalBanks.first(where: { $0.goalName == goalName }) {
                
                let remainingAmount = goal.goalAmount - goal.coins
                return amount > 0 && amount <= wallet.coins && amount <= remainingAmount
            }
            return false
        }
    
    
    
    func removeGoal(goalName: String) {
        goalBanks.removeAll(where: { $0.goalName == goalName })
        try? modelContext.save()
    }
    
    func removeCoinsFromGoal(goalName: String, amount: Int) {
        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
            print("Meta não encontrada")
            return
        }
        wallet.addCoins(amount: amount)
        goal.spendCoins(amount: amount)
        try? modelContext.save()
    }
    
    
    
}
