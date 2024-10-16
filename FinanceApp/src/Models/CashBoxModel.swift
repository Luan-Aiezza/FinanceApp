//
//  CashBoxModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 16/10/24.
//

//
//  TaskModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 16/10/24.
//
import Foundation
import SwiftData

@Model
class CashBoxModel {
    var coins: Int
    var cashBoxDescription: String
    
    init(cashBoxDescription: String) {
        self.coins = 0
        self.cashBoxDescription = cashBoxDescription
    }
    
    func addCoins() -> Void {
        print("addCoins not implemented.")
    }
    func removeCoins() -> Void {
        print("removeCoins not implemented.")
    }
}
