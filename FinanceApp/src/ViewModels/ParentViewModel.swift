//
//  TasksViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 17/10/24.
//

import Foundation
import SwiftUI
import SwiftData

class ParentViewModel: ObservableObject{
    @Environment(\.modelContext) private var modelContext
    @Query var parents: [ParentModel]
    
    func changeCoinValue() -> Void {
        print("changeCoinValue not implemented")
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
    
    func addTaskChild(child: ChildModel, taskDescription: String, value: String, recurrent: Bool, effort: EffortTypes, frequency: FrequencyTypes) -> TaskModel {
        let taskModel = createTask(taskDescription: taskDescription, value: value, recurrent: recurrent, effort: effort, frequency: frequency)
        child.tasks.append(taskModel)
        return taskModel
    }
    
    private func createTask(taskDescription: String, value: String, recurrent: Bool, effort: EffortTypes, frequency: FrequencyTypes) -> TaskModel{
        let taskModel = TaskModel(taskDescription: taskDescription, value: convertStrigToFloat(value: value), recurrent: recurrent, effort: effort, frequency: frequency)
        return taskModel
    }
    private func convertStrigToFloat(value: String) -> Float {
        if let value = Float(value){
            return value
        } else {
            return 0.0
        }
    }
}

