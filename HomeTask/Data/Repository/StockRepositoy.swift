//
//  StockRepositoy.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockRepository: AnyObject {
    func stocks() -> [StockEntity]
    func add(title: String, memo: String?, amount: Int, limit: Int)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
    func update(id: UUID, title: String, memo: String?, amount: Int, limit: Double)
}

class StockRepositoryImpl: StockRepository {
    static let shared = StockRepositoryImpl()
    let dataStore = StockDataStoreFactory.createStockDataStore()
    
    func stocks() -> [StockEntity] {
        return dataStore.fetchAllStocks()
    }
    
    func add(title: String, memo: String?, amount: Int, limit: Int) {
        dataStore.addNewStock(title: title, memo: memo, amount: amount, limit: limit)
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
    
    func update(id: UUID, title: String, memo: String?, amount: Int, limit: Double) {
        dataStore.update(id: id, title: title, memo: memo, amount: amount, limit: limit)
    }
}
