
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
    
    init(goalName: String, goalAmount: Int) {
           self.goalName = goalName
           self.goalAmount = goalAmount
           super.init()
       }
       
       // Método para adicionar moedas à meta
       override func addCoins(amount: Int) {
           guard amount > 0 else { return }
           self.coins += amount
           print("Coins added: \(amount). Amount added to the box: \(self.coins)")
           
           if self.coins >= self.goalAmount {
               print("CONGRATULATIONS! gOAL '\(goalName)' achived.")
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
