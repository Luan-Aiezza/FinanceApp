//
//  TestParentViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 08/11/24.
//

import SwiftData
import SwiftUI

class TestParentViewModel: ObservableObject {
    
    var firstChildId: UUID?
    private var parentService: Service<ParentModel>? = nil
    private var childService: Service<ChildModel>? = nil
    private var taskService: Service<TaskModel>? = nil
    private var goalService: Service<GoalBankModel>? = nil
    
    @Published var parent: ParentModel?
    @Published var children: [ChildModel]?
    @Published var tasks: [TaskModel]?
    @Published var goals: [GoalBankModel]?
    @Published var actualView: PickerOptions = .profile
    @Published var firstChild: ChildModel?
    
    func setup(modelContext: ModelContext){
        parentService = .init(modelContext: modelContext)
        childService = .init(modelContext: modelContext)
        taskService = .init(modelContext: modelContext)
        goalService = .init(modelContext: modelContext)
    }
    
    @MainActor
    func fetch(){
        let parents = parentService?.read()
        parent = parents?.first
        if let childID = parent?.childs.first?.id {
            firstChildId = childID
        }
    }
    
    @MainActor func addChild(name: String) -> Bool{
        var parentReturn: Bool = false
        var childReturn: Bool = false
        
        let newChild = ChildModel(name: name)
        if let parentService = parentService, let parent = parent {
            parentReturn = parentService.update(parent){ parent in
                parent.childs.append(newChild)
            }
        }
        if let childService = childService {
            childReturn = childService.create(newChild)
        }
        fetch()
        return (parentReturn && childReturn)
    }
    
    @MainActor func addTaskChild(child: ChildModel, taskDescription: String, value: String, recurrent: Bool, effort: EffortTypes, frequency: FrequencyTypes) -> Bool {
        
        let taskModel = createTask(taskDescription: taskDescription, value: value, recurrent: recurrent, effort: effort, frequency: frequency)
        taskModel.child = child
        
        var childReturn = false, taskReturn = false, parentReturn = false
        
        if let taskService = taskService {
            taskReturn = taskService.create(taskModel)
        }
        
        if let childService = childService {
            childReturn = childService.update(child) { child in
                child.tasks.append(taskModel)
            }
        }
        
        if let parentService = parentService, let parent = parent {
            parentReturn = parentService.update(parent){ parent in
                if let index = parent.childs.firstIndex(where: {$0.id == child.id}){
                    parent.childs[index] = child
                }
            }
        }
        fetch()
        return (childReturn && parentReturn && taskReturn)
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
