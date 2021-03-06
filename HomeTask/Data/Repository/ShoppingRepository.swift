//
//  ShoppingRepository.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingRepository: AnyObject {
    func items() -> [ShoppingEntity]
    func createOrUpdate(amount: Int, stockId: UUID, stock: StockEntity)
    func delete(id: UUID)
    func delete(ids: [UUID])
    func increment(id: UUID)
    func decrement(id: UUID)
    func purchase(id: UUID, purchased: Bool)
}

class ShoppingRepositoryImpl: ShoppingRepository {
    static let shared = ShoppingRepositoryImpl()
    let dataStore = ShoppingDataStoreFactory.dataStore()
    
    func items() -> [ShoppingEntity] {
        dataStore.fetchAll()
    }
    
    func createOrUpdate(amount: Int, stockId: UUID, stock: StockEntity) {
        dataStore.createOrUpdate(amount: amount, stockId: stockId, stock: stock)
    }

    func delete(id: UUID) {
        dataStore.delete(id: id)
    }
    
    func delete(ids: [UUID]) {
        dataStore.delete(ids: ids)
    }
    
    func increment(id: UUID) {
        dataStore.increment(id: id)
    }
    
    func decrement(id: UUID) {
        dataStore.decrement(id: id)
    }
    
    func purchase(id: UUID, purchased: Bool) {
        dataStore.purchase(id: id, purchased: purchased)
    }
}
