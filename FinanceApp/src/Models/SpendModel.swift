//
//  Untitled 2.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 16/10/24.
//

import Foundation
import SwiftData

@Model
class SpendModel {
    var spendDescription: String
    var coinsSpent: Int
    var date: Date
    
    init(spendDescription: String, coinsSpent: Int) {
        self.spendDescription = spendDescription
        self.coinsSpent = coinsSpent
        self.date = Date()
    }
}
