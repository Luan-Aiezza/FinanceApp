//
//  Untitled.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 16/10/24.
//

import Foundation
import SwiftData

@Model
class ParentModel {
    var name: String
    var childs: [ChildModel] = []
    
    init(name: String) {
        self.name = name
    }
}

