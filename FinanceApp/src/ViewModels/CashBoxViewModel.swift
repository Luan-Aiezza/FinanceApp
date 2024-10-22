//
//  CashBoxViewModel.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 17/10/24.
//



import SwiftUI

class CashBoxViewModel: ObservableObject {
    @Published var wallet: Wallet
    @Published var goalBanks: [GoalBank] = []
    
    init() {
        self.wallet = Wallet()
    }
    
    // Método para adicionar uma nova meta de poupança
    func addGoal(name: String, amount: Int) {
        let newGoal = GoalBank(goalName: name, goalAmount: amount)
        goalBanks.append(newGoal)
    }
    
    // Adiciona moedas à carteira
    func addCoinsToWallet(amount: Int) {
        wallet.addCoins(amount: amount)
    }
    
    // Gasta moedas da carteira
    func spendCoinsFromWallet(amount: Int) {
        wallet.spendCoins(amount: amount)
    }
    
    // Adiciona moedas a uma meta
    func addCoinsToGoal(goalName: String, amount: Int) {
        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
            print("Meta não encontrada")
            return
        }
        goal.addCoins(amount: amount)
        wallet.spendCoins(amount: amount)
    }
    
    // Verifica o progresso de uma meta
//    func goalProgress(goalName: String) -> Double {
//        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
//            return 0.0
//        }
//        return Double(goal.coins) / Double(goal.goalAmount)
//    }
//    
//    func goalProgressColor(goalName: String) -> Color {
//        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
//            // Retorna a cor vermelha se a meta não for encontrada
//            return .red
//        }
//        
//        let progress = goalProgress(goalName: goalName)
//        
//        if progress >= 0.75 {
//            // Retorna verde se o progresso for maior ou igual a 75%
//            return .green
//        } else if progress >= 0.5 {
//            // Retorna amarelo se o progresso for entre 50% e 75%
//            return .yellow
//        } else {
//            // Retorna laranja se o progresso for menor que 50%
//            return .orange
//        }
//
//    }

    
    
    func removeGoal(goalName: String) {
        goalBanks.removeAll(where: { $0.goalName == goalName })
    }
    
    func removeCoinsFromGoal(goalName: String, amount: Int) {
        guard let goal = goalBanks.first(where: { $0.goalName == goalName }) else {
            print("Meta não encontrada")
            return
        }
        wallet.addCoins(amount: amount)
        goal.spendCoins(amount: amount)
    }
    
    
    
}
