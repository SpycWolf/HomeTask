//
//  StockRepositoy.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

protocol StockRepository: AnyObject {
    func stocks() -> [StockEntity]
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
}

class StockRepositoryImpl: StockRepository {
    static let shared = StockRepositoryImpl()
    let dataStore = StockDataStoreFactory.createStockDataStore()
    
    func stocks() -> [StockEntity] {
        return dataStore.fetchAllStocks()
    }
    
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double) {
        dataStore.createOrUpdate(id: id, title: title, memo: memo, amount: amount, limit: limit)
    }

    func delete(id: UUID) {
        dataStore.deleteStock(id: id)
    }
    
    func increment(id: UUID) {
        dataStore.incrementAmount(id: id)
    }
    
    func decrement(id: UUID) {
        dataStore.decrementAmount(id: id)
    }

}
