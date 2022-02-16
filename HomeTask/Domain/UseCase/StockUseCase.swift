//
//  StockUseCase.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockUseCase {
    func stocks() -> [StockModel]
    func add(title: String, memo: String?, amount: Int, limit: Int)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
    func update(stock: StockModel)
}

struct StockUseCaseImpl: StockUseCase {
    let repository: StockRepository
    
    init(repository: StockRepository) {
        self.repository = repository
    }
    
    func stocks() -> [StockModel] {
        repository.stocks().map { StockTranslator().translate($0) }
    }
    
    func add(title: String, memo: String?, amount: Int, limit: Int) {
        repository.add(title: title, memo: memo, amount: amount, limit: limit)
    }
    
    func delete(id: UUID) {
        repository.delete(id: id)
    }
    
    func increment(id: UUID) {
        repository.increment(id: id)
    }
    
    func decrement(id: UUID) {
        repository.decrement(id: id)
    }
    
    func update(stock: StockModel) {
        repository.update(id: stock.id, title: stock.title,
                          memo: stock.memo, amount: stock.amount, limit: stock.limit)
    }
}
