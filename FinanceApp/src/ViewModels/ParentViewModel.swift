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
    func createTask(child: ChildModel, taskDescription: String, value: Float, recurrent: Bool) -> Void {
        let newTask = TaskModel(taskDescription: taskDescription, value: value, recurrent: recurrent)
        child.task.append(newTask)
    }
    func updateTask() -> Void {
        print("updateTask not implemented")
    }
    func removeTask() -> Void {
        print("removeTask not implemented")
    }
}
