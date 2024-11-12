//
//  PCrud.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 08/11/24.
//

protocol PCrud {
    associatedtype ModelType
    func create(_ model: ModelType) -> Bool
    func read() -> [ModelType]
    func update(_ model: ModelType, changes: (inout ModelType) -> Void) -> Bool
    func delete(_ model: ModelType) -> Bool
}
