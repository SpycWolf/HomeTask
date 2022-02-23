//
//  ShoppingRepository.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingRepository: AnyObject {
    func items() -> [ShoppingEntity]
    func createOrUpdate(id: UUID, amount: Int, stockId: UUID, stock: StockEntity)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
}

class ShoppingRepositoryImpl: ShoppingRepository {
    static let shared = ShoppingRepositoryImpl()
    let dataStore = ShoppingDataStoreFactory.dataStore()
    
    func items() -> [ShoppingEntity] {
        dataStore.fetchAll()
    }
    
    func createOrUpdate(id: UUID, amount: Int, stockId: UUID, stock: StockEntity) {
        dataStore.createOrUpdate(id: id, amount: amount, stockId: stockId, stock: stock)
    }

    func delete(id: UUID) {
        dataStore.delete(id: id)
    }
    
    func increment(id: UUID) {
        dataStore.increment(id: id)
    }
    
    func decrement(id: UUID) {
        dataStore.decrement(id: id)
    }
    
}
