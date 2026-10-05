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
    static let shared = ParentViewModel()
    private init(){}
    
    var modelContext: ModelContext? = nil
    @Published var parent: ParentModel?
    @Published var childdren: [ChildModel] = []
    @Published var tasks: [TaskModel] = []
    @Published var childID: UUID?
    
    private var parentService: Service<ParentModel>? = nil
    private var childService: Service<ChildModel>? = nil
    private var taskService: Service<TaskModel>? = nil
    private var cashBoxService: Service<CashBoxModel>? = nil
    
    @Published var activePiggyBank: Int = 0
    @Published var coinsInPiggyBank: Int = 0
    @Published var tasksDoneInCurrentMonth: Int = 0
    @Published var valueOfTasksDoneInCurrentMonth: Int = 0
    
    @Published var isChangeTaskDone: Bool = false
    @Published var currentChild: UUID?
    
    
    func setup(modelContext: ModelContext){
        parentService = .init(modelContext: modelContext)
        childService = .init(modelContext: modelContext)
        taskService = .init(modelContext: modelContext)
        cashBoxService = .init(modelContext: modelContext)
    }
    
    func fetch(id: UUID? = nil) {
        let parents = parentService?.read()
        parent = parents?.first
        
        if let existingParent = parents?.first {
            parent = existingParent
        } else {
            // Criar e salvar o novo Parent
            let newParent = ParentModel(name: "Default Parent")
            modelContext?.insert(newParent)
            do {
                try modelContext?.save()
                parent = newParent
            } catch {
                print("Error saving parent: \(error)")
            }
        }
        
        if let childdren = parent?.childs {
            self.childdren = childdren
        }
        if let id = id {
            childID = id
        } else {
            childID = childdren.first?.id
        }
        if let child = childdren.first(where: {$0.id == childID}){
            tasks = child.tasks
            activePiggyBank = countActivePiggyBank(child: child)
            
            coinsInPiggyBank = countCoinsInPiggyBanks(child: child)
            
            let tasksDoneInMonth = taskDoneInMonth(child: child)
            
            tasksDoneInCurrentMonth = countTaskDoneInMonth(tasks: tasksDoneInMonth)
            
            valueOfTasksDoneInCurrentMonth = valueOfCoinsInMonth(tasks: tasksDoneInMonth)
        }
        
        if let parent = parent {
            childdren = parent.childs
        }
        
        print("Instanciei o ParentViewModel \(childID)")
    }
    
    
    func changeCoinValue() -> Void {
        print("changeCoinValue not implemented")
    }
    
    // Child Section
    
    func addChild(name: String) {
        
        let newChild = ChildModel(name: name)
        let wallet = CashBoxModel(cashBoxDescription: "Wallet")
        
        if let childService = childService,
           let parentService = parentService,
           let cashboxService = cashBoxService,
           let parent = parent
        {
            let _ = parentService.update(parent) { parent in
                let _ = cashBoxService?.create(wallet)
                newChild.cashBoxes.append(wallet)
                let _ = childService.create(newChild)
                parent.childs.append(newChild)
            }
        }
    }
    
    func upDateChildProfile(name: String?, image: String?){
        if let parentService = parentService,
           let childService = childService,
           let child = childdren.first(where: {$0.id == childID}),
           let parent = parent{
            let _ = childService.update(child) { child in
                if let name = name {
                    child.name = name
                }
                if let image = image {
                    child.profileImage = image
                }
                let _ = parentService.update(parent){ parent in
                    if let index = parent.childs.firstIndex(where: {$0.id == child.id}){
                        parent.childs[index] = child
                    }
                }
            }
        }
        
    }
    
    func deleteChildProfile() {
        if let childService = childService,
           let childToDelete = childdren.first(where: {$0.id == childID}){
            let _ = childService.delete(childToDelete)
        }
        fetch()
    }
    
    // Task Section
    
    func addTaskChild(child: ChildModel, taskDescription: String, value: String, recurrent: Bool, effort: EffortTypes, frequency: FrequencyTypes) {
        let taskModel = createTask(taskDescription: taskDescription, value: value, recurrent: recurrent, effort: effort, frequency: frequency)
        
        if let parentService = parentService,
           let childService = childService,
           let taskService = taskService,
           let child = childdren.first(where: {$0.id == childID}),
           let parent = parent{
            taskModel.child = child
            let _ = taskService.create(taskModel)
            let _ = childService.update(child) { child in
                child.tasks.append(taskModel)
                let _ = parentService.update(parent) { parent in
                    if let index = parent.childs.firstIndex(where: {$0.id == childID}){
                        parent.childs[index] = child
                    }
                }
            }
            
        }
        fetch()
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
    
    func deleteTask(task: TaskModel){
        if let taskService = taskService {
            let _ = taskService.delete(task)
        }
        fetch()
    }
    
    func updateTask(task: TaskModel, description: String, effort: EffortTypes){
        let value = setValueEffort(effort: effort)
        
        if let taskService = taskService,
           let parentService = parentService,
           let childService = childService,
           let parent = parent{
            if let childIndex = parent.childs.firstIndex(where: {$0.id == childID}),
               let taskIndex = parent.childs[childIndex].tasks.firstIndex(where: {$0.id == task.id}){
                let _ =  childService.update(parent.childs[childIndex]) { child in
                    let _ = parentService.update(parent) { parent in
                        let _ = taskService.update(parent.childs[childIndex].tasks[taskIndex]) { task in
                            task.taskDescription = description
                            task.value = value
                            task.effort = effort
                            child.tasks[taskIndex] = task
                            parent.childs[childIndex] = child
                        }
                    }
                    tasks = child.tasks
                }
            }
        }
    }
    
    private func setValueEffort(effort: EffortTypes) -> Int{
        switch effort {
        case .easy:
            return 1
        case .medium:
            return 3
        case .hard:
            return 5
        }
    }
    
    // History Section
    
    private func countActivePiggyBank(child: ChildModel) -> Int {
        let activePiggyBanks = child.goals.count(where: {$0.finishDate != nil})
        return activePiggyBanks
    }
    
    private func countCoinsInPiggyBanks(child: ChildModel) -> Int {
        let coinsInPiggyBanks = child.goals.reduce(0) {
            $0 + $1.cashBox.coins
        }
        return coinsInPiggyBanks
    }
    
    private func valueOfCoinsInMonth(tasks: [TaskModel]) -> Int {
        let valueOfCoins = tasks.reduce(0) {
            $0 + $1.value
        }
        return Int(valueOfCoins)
    }
    
    private func countTaskDoneInMonth(tasks: [TaskModel]) -> Int {
        return tasks.count
    }
    
    private func taskDoneInMonth(child: ChildModel) -> [TaskModel] {
        let countComplete = child.tasks.filter{ task in
            guard task.isDone else { return false }
            let calendar = Calendar.current
            let month = calendar.component(.month, from: Date())
            let year = calendar.component(.year, from: Date())
            if let finishDate = task.finishDate {
                let taskMonth = calendar.component(.month, from: finishDate)
                let taskYear = calendar.component(.year, from: finishDate)
                return taskMonth == month && taskYear == year
            }
            
            return month == month && year == year
        }
        return countComplete
    }
}

