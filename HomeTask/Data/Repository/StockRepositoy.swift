//
//  StockRepositoy.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

protocol StockRepository: AnyObject {
    func stocks() -> [StockEntity]
    func stock(by id: UUID) -> StockEntity
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
    func updateAmount(id: UUID, amount: Int)
}

class StockRepositoryImpl: StockRepository {
    static let shared = StockRepositoryImpl()
    let dataStore = StockDataStoreFactory.dataStore()
    
    func stocks() -> [StockEntity] {
        dataStore.fetchAll()
    }
    
    func stock(by id: UUID) -> StockEntity {
        dataStore.fetch(by: id) ?? StockEntity()
    }
    
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double) {
        dataStore.createOrUpdate(id: id, title: title, memo: memo, amount: amount, limit: limit)
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

    func updateAmount(id: UUID, amount: Int) {
        dataStore.updateAmount(id: id, amount: amount)
    }
    
}
