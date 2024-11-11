//
//  FinanceAppApp.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import SwiftUI
import SwiftData

typealias ChildModel = FinanceAppSchemaV5.ChildModel
typealias ParentModel = FinanceAppSchemaV5.ParentModel
typealias SpendModel = FinanceAppSchemaV5.SpendModel
typealias TaskModel = FinanceAppSchemaV5.TaskModel
typealias CashBoxModel = FinanceAppSchemaV5.CashBoxModel
typealias GoalBankModel = FinanceAppSchemaV5.GoalBankModel

@main
struct FinanceAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CashBoxModel.self, ChildModel.self, ParentModel.self , SpendModel.self, TaskModel.self, GoalBankModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema,migrationPlan: FinanceAppMigrationPlan.self,
                                    configurations: [modelConfiguration])
        } catch {
            print(error)
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            ProfilesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
