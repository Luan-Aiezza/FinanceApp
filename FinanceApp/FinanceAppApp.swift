//
//  FinanceAppApp.swift
//  FinanceApp
//
//  Created by Luan Aiezza on 16/10/24.
//

import SwiftUI
import SwiftData

typealias ChildModel = FinanceAppSchemaV6.ChildModel
typealias ParentModel = FinanceAppSchemaV6.ParentModel
typealias SpendModel = FinanceAppSchemaV6.SpendModel
typealias TaskModel = FinanceAppSchemaV6.TaskModel
typealias CashBoxModel = FinanceAppSchemaV6.CashBoxModel
typealias GoalBankModel = FinanceAppSchemaV6.GoalBankModel

@main
struct FinanceAppApp: App {
    @ObservedObject var navigation = AppNavigation.shared
    
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
            // ContentView()
//            ProfilesView()
            
            NavigationStack(path: $navigation.path){
                ContentView()
                    .navigationDestination(for: ProfileNav.self) { view in
                        navigation.getDestination(to: view)
                    }
            }
            .tint(Color.purple)
            .font(
                Font.custom("Pally-Regular", size: 17)
                    .weight(.medium)
            )
        }
        .modelContainer(sharedModelContainer)
    }
}
