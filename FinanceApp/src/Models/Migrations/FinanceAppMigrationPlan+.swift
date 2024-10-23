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
        [FInanceAppSchemaV1.self,
        FinanceAppSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
//    static var migrateV1toV2 = MigrationStage.lightweight(fromVersion: FInanceAppSchemaV1.self, toVersion: FinanceAppSchemaV2.self)
    
static var migrateV1toV2: MigrationStage {
    .custom(fromVersion: <#T##any VersionedSchema.Type#>, toVersion: <#T##any VersionedSchema.Type#>, willMigrate: <#T##((ModelContext) throws -> Void)?##((ModelContext) throws -> Void)?##(_ context: ModelContext) throws -> Void#>, didMigrate: <#T##((ModelContext) throws -> Void)?##((ModelContext) throws -> Void)?##(_ context: ModelContext) throws -> Void#>)
    }


