//
//  FinanceAppApp.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import SwiftUI
import SwiftData

typealias ChildModel = FinanceAppSchemaV4.ChildModel
typealias ParentModel = FinanceAppSchemaV4.ParentModel
typealias SpendModel = FinanceAppSchemaV4.SpendModel
typealias TaskModel = FinanceAppSchemaV4.TaskModel
typealias CashBoxModel = FinanceAppSchemaV4.CashBoxModel
typealias GoalBankModel = FinanceAppSchemaV4.GoalBankModel

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
