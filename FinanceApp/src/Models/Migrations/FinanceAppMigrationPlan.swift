//
//  ChildMigrationPlan.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 21/10/24.
//

import Foundation
import SwiftData

enum FinanceAppMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type]{
        [
         FInanceAppSchemaV1.self,
         FinanceAppSchemaV2.self
        ]
    }
    
    static var stages: [MigrationStage] {
        [MigrateV1toV2]
    }
}

extension FinanceAppMigrationPlan {
    
    static var MigrateV1toV2 = MigrationStage.custom(fromVersion: FInanceAppSchemaV1.self, toVersion: FinanceAppSchemaV2.self, willMigrate: {context in 
        let tasks = try context.fetch(FetchDescriptor<FinanceAppSchemaV2.TaskModel>())
        tasks.forEach{ task in
            if let _ = task.frequency {
                task.frequency = .daily
                }
            if let _ = task.effort {
                task.effort = .easy
            }
            }
    }, didMigrate: { context in
        let cashBoxes = try! context.fetch(FetchDescriptor<FinanceAppSchemaV2.CashBoxModel>())
        cashBoxes.forEach{ cashBox in
            cashBox.cashBoxDescription = "No description"
            cashBox.id = UUID()
        }
        let tasks = try! context.fetch(FetchDescriptor<FinanceAppSchemaV2.TaskModel>())
        tasks.forEach{ task in
            task.frequency = .daily
            task.effort = .easy
        }
        try! context.save()
    })
}

