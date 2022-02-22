//
//  StockEntityLocalDataSource.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockDataStore {
    func fetchAllStocks() -> [StockEntity]
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double)
    func deleteStock(id: UUID)
    func incrementAmount(id: UUID)
    func decrementAmount(id: UUID)
}

struct StockDataStoreImpl: StockDataStore {
    func fetchAllStocks() -> [StockEntity] {
        return StockEntity.fetchAll()
    }
    
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double) {
        StockEntity.createOrUpdate(id: id, title: title, memo: memo, amount: amount, limit: limit)
    }

    func deleteStock(id: UUID) {
        StockEntity.deleteStock(id: id)
    }
    
    func incrementAmount(id: UUID) {
        StockEntity.increment(id: id)
    }
    
    func decrementAmount(id: UUID) {
        StockEntity.decrement(id: id)
    }

}

struct StockDataStoreFactory {
    static func createStockDataStore() -> StockDataStore {
        StockDataStoreImpl()
    }
}
