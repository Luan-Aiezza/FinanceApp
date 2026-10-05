//
//  Service.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 08/11/24.
//

import SwiftData

struct Service<T: PersistentModel>: PCrud{
    
    typealias ModelType = T
    var modelContext: ModelContext
    
    func create(_ model: T) -> Bool {
        modelContext.insert(model)
        do{
            try modelContext.save()
            return true
        } catch {
            return false
        }
    }
    
    func read() -> [T] {
        let descriptor = FetchDescriptor<T>()
        do{
            
            let results = try modelContext.fetch(descriptor)
            return results
        } catch {
            return []
        }
    }
    
    func update(_ model: T, changes: (inout T) -> Void) -> Bool {
        var modelToUpdate = model
        
        do{
            try modelContext.transaction {
                changes(&modelToUpdate)
            }
            return true
        } catch {
            return false
        }
    }
    
    func delete(_ model: T) -> Bool {
        do{
            modelContext.delete(model)
            try modelContext.save()
            return true
        } catch {
            return false
        }
    }
}
