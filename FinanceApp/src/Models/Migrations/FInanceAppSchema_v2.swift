import Foundation
import SwiftData

enum FinanceAppSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [ChildModel.self, ParentModel.self , SpendModel.self, TaskModel.self, CashBoxModel.self, GoalBankModel.self]
    }
    static var versionIdentifier: Schema.Version = .init(1, 1, 0)
    
}

extension FinanceAppSchemaV2 {
    @Model
    class ChildModel {
        var id: UUID
        var name: String
        var tasks: [TaskModel] = []
        var cashBoxes: [CashBoxModel] = []
        var spends: [SpendModel] = []
        
        init(name: String) {
            self.name = name
            self.id = UUID()
        }
    }
    
    @Model
    class ParentModel {
        var id: UUID
        var name: String
        var childs: [ChildModel] = []
        
        init(name: String) {
            self.name = name
            self.id = UUID()
        }
    }
    
    @Model
    class CashBoxModel {
        var coins: Int
        @Attribute(originalName: "cashBoxDescription")
        var cashBoxDescription: String
        @Attribute(originalName: "id")
        var id: UUID
        
        init(cashBoxDescription: String, coins: Int = 0) {
            self.id = UUID()
            self.coins = coins
            self.cashBoxDescription = cashBoxDescription
        }
        
        func addCoins(amount: Int) {
                if amount > 0 {
                    self.coins += amount
                }
            }
    }
    
    @Model
    class SpendModel {
        var spendDescription: String
        var coinsSpent: Int
        var date: Date
        
        init(spendDescription: String, coinsSpent: Int) {
            self.spendDescription = spendDescription
            self.coinsSpent = coinsSpent
            self.date = Date()
        }
    }

    @Model
    class TaskModel {
        var taskDescription: String
        var value: Float
        var isDone: Bool
        var recurrent: Bool
        @Attribute(originalName: "frequency")
        var frequency: FrequencyTypes?
        var creationDate: Date
        var finishDate: Date?
        @Attribute(originalName: "effort")
        var effort: EffortTypes?
        
        init(taskDescription: String, value: Float, recurrent: Bool = false, effort: EffortTypes = .easy, frequency: FrequencyTypes = .daily) {
            self.taskDescription = taskDescription
            self.value = value
            self.isDone = false
            self.recurrent = recurrent
            self.creationDate = Date()
            self.effort = effort
            self.frequency = frequency
        }
    }
    
    @Model
    class GoalBankModel {
        var goalAmount: Int
        var creationDate: Date
        var finishDate: Date?
        var cashBox: CashBoxModel
        
        init(goalName: String, goalAmount: Int) {
            self.goalAmount = goalAmount
            self.creationDate = Date()
            self.cashBox = CashBoxModel(cashBoxDescription: goalName)
        }
        
    }
    
}
