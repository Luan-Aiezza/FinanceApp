import SwiftData

extension FinanceAppMigrationPlan {
    static var MigrateV5toV6 = MigrationStage.lightweight(fromVersion: FinanceAppSchemaV5.self, toVersion: FinanceAppSchemaV6.self)
}
