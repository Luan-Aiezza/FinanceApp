import Foundation
import SwiftData

enum FInanceAppSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [ChildModel.self]
    }
    static var versionIdentifier = Schema.Version(1,0,0)
    
}

extension FInanceAppSchemaV1 {
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
    //    var cashBoxDescription: String
        
        init() {
            self.coins = 0
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
    //    var frequency: frequencyTypes = frequencyTypes.none
        var creationDate: Date
        var finishDate: Date?
        
        init(taskDescription: String, value: Float, recurrent: Bool = false) {
            self.taskDescription = taskDescription
            self.value = value
            self.isDone = false
            self.recurrent = recurrent
            self.creationDate = Date()
        }
        
        func finishTask() -> Void {
            isDone = true
        }
        
    //    enum frequencyTypes {
    //        case daily, weekly, monthly, none
    //    }
    }

    
}
