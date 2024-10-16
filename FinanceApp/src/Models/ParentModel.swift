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
    
    func changeCoinValue() -> Void {
        print("changeCoinValue not implemented")
    }
    func createTask() -> Void {
        print("createTask not implemented")
    }
    func updateTask() -> Void {
        print("updateTask not implemented")
    }
    func removeTask() -> Void {
        print("removeTask not implemented")
    }
}

