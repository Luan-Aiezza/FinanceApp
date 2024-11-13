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
    
    var modelContext: ModelContext? = nil
    @Published var parent: ParentModel?
    @Published var childdren: [ChildModel]?
    @Published var firstChildId: UUID?
    
    init() {
        self.fetch()
    }

        
    // Método para remover a criança da lista
    func removeChild(_ child: ChildModel) {
        // Verifica se o array não é nil
        if var children = childdren {
            // Tenta encontrar o índice da criança
            if let index = children.firstIndex(where: { $0.id == child.id }) {
                // Remove a criança pelo índice
                children.remove(at: index)
                // Atualiza a lista de crianças
                childdren = children
            }
        }
    }

    func fetch() {
        do{
            let parentDescriptor = FetchDescriptor<ParentModel>()
            let parents = (try? (modelContext?.fetch(parentDescriptor) ?? [])) ?? []
            parent = parents.first ?? ParentModel(name: "No Parent")
            childdren = parent?.childs
            firstChildId = parent?.childs.first?.id
        }
    }
    
    
    
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
            parent?.childs.append(newChild)
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
    private func convertStrigToFloat(value: String) -> Int {
        if let value = Int(value){
            return value
        } else {
            return 0
        }
    }
}

