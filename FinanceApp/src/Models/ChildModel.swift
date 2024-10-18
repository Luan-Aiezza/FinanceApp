//
//  ChildModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 16/10/24.
//

import Foundation
import SwiftData

@Model
class ChildModel {
    var name: String
    var tasks: [TaskModel] = []
    var cashBoxes: [CashBoxModel] = []
    var spends: [SpendModel] = []
    
    init(name: String) {
        self.name = name
    }
    
    func useCoins() -> Void {
        print("useCoins not implemeted.")
    }
}
