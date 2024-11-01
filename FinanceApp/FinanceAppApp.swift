//
//  FinanceAppApp.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import SwiftUI
import SwiftData

typealias ChildModel = FinanceAppSchemaV3.ChildModel
typealias ParentModel = FinanceAppSchemaV3.ParentModel
typealias SpendModel = FinanceAppSchemaV3.SpendModel
typealias TaskModel = FinanceAppSchemaV3.TaskModel
typealias CashBoxModel = FinanceAppSchemaV3.CashBoxModel
typealias GoalBankModel = FinanceAppSchemaV3.GoalBankModel

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
