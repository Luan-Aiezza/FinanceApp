//
//  FinanceAppApp.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import SwiftUI
import SwiftData

typealias ChildModel = FInanceAppSchemaV1.ChildModel
typealias ParentModel = FInanceAppSchemaV1.ParentModel
typealias SpendModel = FInanceAppSchemaV1.SpendModel
typealias TaskModel = FInanceAppSchemaV1.TaskModel
typealias CashBoxModel = FInanceAppSchemaV1.CashBoxModel

@main
struct FinanceAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CashBoxModel.self, ChildModel.self, ParentModel.self , SpendModel.self, TaskModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema,migrationPlan: FinanceAppMigrationPlan.self,
                                    configurations: [modelConfiguration])
        } catch {
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
