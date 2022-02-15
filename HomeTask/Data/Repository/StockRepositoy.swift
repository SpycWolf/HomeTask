//
//  StockRepositoy.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockRepository: AnyObject {
    func stocks() -> [StockEntity]
}

class StockRepositoryImpl: StockRepository {
    static let shared = StockRepositoryImpl()
    
    func stocks() -> [StockEntity] {
        let dataStore = StockLocalDataStoreFactory.createStockLocalDataStore()
        return dataStore.fetchAllStocks()
    }
}
