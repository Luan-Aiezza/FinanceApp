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
        [FInanceAppSchemaV1.self]
    }
    
    static var stages: [MigrationStage] {
        []
    }
    
}
