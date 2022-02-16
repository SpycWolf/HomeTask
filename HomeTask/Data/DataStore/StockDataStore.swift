//
//  StockEntityLocalDataSource.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockDataStore {
    func fetchAllStocks() -> [StockEntity]
    func addNewStock(title: String, memo: String?, amount: Int, limit: Int)
    func deleteStock(id: UUID)
    func incrementAmount(id: UUID)
    func decrementAmount(id: UUID)
    func update(id: UUID, title: String, memo: String?, amount: Int, limit: Int)
}

struct StockDataStoreImpl: StockDataStore {
    func fetchAllStocks() -> [StockEntity] {
        return StockEntity.fetchAll()
    }
    
    func addNewStock(title: String, memo: String?, amount: Int, limit: Int) {
        StockEntity.newStock(title: title, memo: memo, amount: amount, limit: limit)
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
    
    func update(id: UUID, title: String, memo: String?, amount: Int, limit: Int) {
        StockEntity.update(id: id, title: title, memo: memo, amount: amount, limit: limit)
    }
}

struct StockDataStoreFactory {
    static func createStockDataStore() -> StockDataStore {
        StockDataStoreImpl()
    }
}
