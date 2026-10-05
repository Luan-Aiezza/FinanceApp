import SwiftData

extension FinanceAppMigrationPlan {
    static var MigrateV4toV5 = MigrationStage.custom(fromVersion: FinanceAppSchemaV4.self, toVersion: FinanceAppSchemaV5.self, willMigrate: nil, didMigrate:  { context in
        do {
            // Fetch all objects of each model type in V5
            let parent = try context.fetch(FetchDescriptor<FinanceAppSchemaV5.ParentModel>())
            let tasks = try context.fetch(FetchDescriptor<FinanceAppSchemaV5.TaskModel>())
            let cashBoxes = try context.fetch(FetchDescriptor<FinanceAppSchemaV5.CashBoxModel>())
            let goals = try context.fetch(FetchDescriptor<FinanceAppSchemaV5.GoalBankModel>())
            let children = try context.fetch(FetchDescriptor<FinanceAppSchemaV5.ChildModel>())

            // Create dictionaries for quick lookup by UUID
            let tasksById = Dictionary(grouping: tasks, by: { $0.id })
            let cashBoxesById = Dictionary(grouping: cashBoxes, by: { $0.id })
            let goalsById = Dictionary(grouping: goals, by: { $0.id })
            let childrenById = Dictionary(grouping: children, by: { $0.id })

            // Iterate over parents and children to set relationships
            parent.forEach { parent in
                children.forEach { child in
                    // Associate parent with child if relationship exists
                    if parent.childs.contains(where: { $0.id == child.id }) {
                        child.parent = parent
                    }

                    // Link tasks to child
                    child.tasks.forEach { task in
                        if let matchingTasks = tasksById[task.id] {
                            matchingTasks.forEach { $0.child = child }
                        }
                    }

                    // Link cashBoxes to child
                    child.cashBoxes.forEach { cashBox in
                        if let matchingCashBoxes = cashBoxesById[cashBox.id] {
                            matchingCashBoxes.forEach { $0.child = child }
                        }
                    }

                    // Link goals to child
                    child.goals.forEach { goal in
                        if let matchingGoals = goalsById[goal.id] {
                            matchingGoals.forEach { $0.child = child }
                        }
                    }
                }
            }
        } catch {
            print("Error during migration: \(error)")
        }
    })
}
