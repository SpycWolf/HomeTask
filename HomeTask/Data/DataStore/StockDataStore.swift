//
//  StockEntityLocalDataSource.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

protocol StockDataStore {
    func fetchAll() -> [StockEntity]
    func fetch(by id: UUID) -> StockEntity?
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
    func updateAmount(id: UUID, amount: Int)
}

struct StockDataStoreImpl: StockDataStore {
    func fetchAll() -> [StockEntity] {
        StockEntity.fetchAll()
    }
    
    func fetch(by id: UUID) -> StockEntity? {
        StockEntity.find(by: id)
    }
    
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double) {
        StockEntity.createOrUpdate(id: id, title: title, memo: memo, amount: amount, limit: limit)
    }

    func delete(id: UUID) {
        StockEntity.delete(id: id)
    }
    
    func increment(id: UUID) {
        StockEntity.increment(id: id)
    }
    
    func decrement(id: UUID) {
        StockEntity.decrement(id: id)
    }
    
    func updateAmount(id: UUID, amount: Int) {
        StockEntity.updateAmount(id: id, amount: amount)
    }

}

struct StockDataStoreFactory {
    static func dataStore() -> StockDataStore {
        StockDataStoreImpl()
    }
}
