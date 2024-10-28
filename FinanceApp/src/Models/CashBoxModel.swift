
import Foundation
import SwiftData

//@Model
//class CashBoxModel {
//    var coins: Int
////    var cashBoxDescription: String
//    
//    init() {
//        self.coins = 0
//    }
//    
//    func addCoins(amount: Int) {
//            if amount > 0 {
//                self.coins += amount
//            }
//        }
//}
class Wallet : CashBoxModel {
    
    
    // Método para gastar moedas
        func spendCoins(amount: Int) {
            guard amount > 0, amount <= self.coins else {
                print("Erro: Quantidade inválida ou saldo insuficiente.")
                return
            }
            self.coins -= amount
            print("Coins spented: \(amount). current balance: \(self.coins)")
        }
    
}

class GoalBank : CashBoxModel {
    
    required init(backingData: any SwiftData.BackingData<CashBoxModel>) {
        fatalError("init(backingData:) has not been implemented")
    }
    

    var goalName: String
    var goalAmount: Int
    var goalAchievedDate: Date?
    
    init(goalName: String, goalAmount: Int) {
           self.goalName = goalName
           self.goalAmount = goalAmount
           super.init()
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
    
    func spendCoins(amount: Int) {
        guard amount > 0, amount <= self.coins else {
            print("Erro: Quantidade inválida ou saldo insuficiente.")
            return
        }
        self.coins -= amount
        print("Coins spented: \(amount). current balance: \(self.coins)")
    }
    
  
}
