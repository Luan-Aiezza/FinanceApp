//
//  TasksViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 17/10/24.
//

import Foundation
import SwiftUI

struct ParentViewModel {
    func changeCoinValue() -> Void {
        print("changeCoinValue not implemented")
    }
    func createTask(child: ChildModel, taskToAdd: TaskModel) -> Void {
        child.tasks.append(taskToAdd)
    }
    
    func updateTask() -> Void {
        print("updateTask not implemented")
    }
    func removeTask() -> Void {
        print("removeTask not implemented")
    }
}
