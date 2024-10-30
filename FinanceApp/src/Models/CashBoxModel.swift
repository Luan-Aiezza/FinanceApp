import Foundation
import SwiftData


// Classe para carteira
class Wallet: CashBoxModel {
    
    // Método para gastar moedas
    func spendCoins(amount: Int) {
        guard amount > 0, amount <= self.coins else {
            print("Erro: Quantidade inválida ou saldo insuficiente.")
            return
        }
        self.coins -= amount
        print("Coins spented: \(amount). Current balance: \(self.coins)")
    }
}

// Classe para metas
class GoalBank: CashBoxModel {
    
    required init(backingData: any SwiftData.BackingData<CashBoxModel>) {
        fatalError("init(backingData:) has not been implemented")
    }
    var goalID: UUID
    var goalName: String
    var goalAmount: Int
    var goalAchievedDate: Date?
    
    init(goalName: String, goalAmount: Int) {
            self.goalID = UUID()
            self.goalName = goalName
            self.goalAmount = goalAmount
        super.init(cashBoxDescription: goalName)
        }
    
    // Método para adicionar moedas à meta
    override func addCoins(amount: Int) {
        guard amount > 0 else { return }
        let possibleAddition = min(amount, goalAmount - self.coins)
        self.coins += possibleAddition
        
        if self.coins >= self.goalAmount {
            self.goalAchievedDate = Date()
            print("CONGRATULATIONS! Goal '\(goalName)' achieved on \(self.goalAchievedDate!)")
        }
    }
    
    // Método para gastar moedas da meta
    func spendCoins(amount: Int) {
        guard amount > 0, amount <= self.coins else {
            print("Erro: Quantidade inválida ou saldo insuficiente.")
            return
        }
        self.coins -= amount
        print("Coins spented: \(amount). Current balance: \(self.coins)")
    }
}
