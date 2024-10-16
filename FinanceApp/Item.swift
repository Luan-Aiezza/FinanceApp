//
//  Item.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
