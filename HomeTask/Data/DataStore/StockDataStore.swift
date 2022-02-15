//
//  StockEntityLocalDataSource.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockDataStore {
    func fetchAllStocks() -> [StockEntity]
}

struct StockDataStoreImpl: StockDataStore {
    func fetchAllStocks() -> [StockEntity] {
        return StockEntity.fetchAll()
    }
}

struct StockLocalDataStoreFactory {
    static func createStockLocalDataStore() -> StockDataStore {
        StockDataStoreImpl()
    }
}
