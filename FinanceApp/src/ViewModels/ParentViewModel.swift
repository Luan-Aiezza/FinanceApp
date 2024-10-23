//
//  TasksViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 17/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ParentViewModel {
    @Query var parents: [ParentModel]
    func changeCoinValue() -> Void {
        print("changeCoinValue not implemented")
    }
    func createTask(child: ChildModel, taskToAdd: TaskModel) -> Void {
        child.tasks.append(taskToAdd)
    }
    func updateTask(taskToUpdate: TaskModel) {
        print("updateTask not implemented")
    }
    func removeTask() -> Void {
        print("removeTask not implemented")
    }
    
    func addChild(name: String) -> ChildModel{
        let newChild = ChildModel(name: name)
        if let parent = parents.first{
            parent.childs.append(newChild)
        }
        return newChild
    }
}
