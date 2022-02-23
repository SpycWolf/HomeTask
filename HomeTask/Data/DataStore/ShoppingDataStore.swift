//
//  ShoppingDataStore.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingDataStore {
    func fetchAll() -> [ShoppingEntity]
    func createOrUpdate(id: UUID, amount: Int, stockId: UUID, stock: StockEntity)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
}

struct ShoppingDataStoreImpl: ShoppingDataStore {
    func fetchAll() -> [ShoppingEntity] {
        ShoppingEntity.fetchAll()
    }
    
    func createOrUpdate(id: UUID, amount: Int, stockId: UUID, stock: StockEntity) {
        ShoppingEntity.createOrUpdate(id: id, amount: amount, stockId: stockId, stock: stock)
    }

    func delete(id: UUID) {
        ShoppingEntity.delete(id: id)
    }
    
    func increment(id: UUID) {
        ShoppingEntity.increment(id: id)
    }
    
    func decrement(id: UUID) {
        ShoppingEntity.decrement(id: id)
    }
    
}

struct ShoppingDataStoreFactory {
    static func dataStore() -> ShoppingDataStore {
        ShoppingDataStoreImpl()
    }
}
