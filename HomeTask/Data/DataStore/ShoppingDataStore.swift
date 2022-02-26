//
//  ShoppingDataStore.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingDataStore {
    func fetchAll() -> [ShoppingEntity]
    func createOrUpdate(amount: Int, stockId: UUID, stock: StockEntity)
    func delete(id: UUID)
    func delete(ids: [UUID])
    func increment(id: UUID)
    func decrement(id: UUID)
    func purchase(id: UUID, purchased: Bool)
}

struct ShoppingDataStoreImpl: ShoppingDataStore {
    func fetchAll() -> [ShoppingEntity] {
        ShoppingEntity.fetchAll()
    }
    
    func createOrUpdate(amount: Int, stockId: UUID, stock: StockEntity) {
        ShoppingEntity.createOrUpdate(amount: amount, stockId: stockId, stock: stock)
    }

    func delete(id: UUID) {
        ShoppingEntity.delete(id: id)
    }
    
    func delete(ids: [UUID]) {
        ShoppingEntity.delete(ids: ids)
    }
    
    func increment(id: UUID) {
        ShoppingEntity.increment(id: id)
    }
    
    func decrement(id: UUID) {
        ShoppingEntity.decrement(id: id)
    }
    
    func purchase(id: UUID, purchased: Bool) {
        ShoppingEntity.purchase(id: id, purchased: purchased)
    }
    
}

struct ShoppingDataStoreFactory {
    static func dataStore() -> ShoppingDataStore {
        ShoppingDataStoreImpl()
    }
}
