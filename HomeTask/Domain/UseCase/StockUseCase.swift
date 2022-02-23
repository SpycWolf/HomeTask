//
//  StockUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

protocol StockUseCase {
    func stocks() -> [StockModel]
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
}

struct StockUseCaseImpl: StockUseCase {
    let repository: StockRepository
    
    init(repository: StockRepository) {
        self.repository = repository
    }
    
    func stocks() -> [StockModel] {
        repository.stocks().map { StockTranslator().translate($0) }
    }
    
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double) {
        repository.createOrUpdate(id: id, title: title, memo: memo, amount: amount, limit: limit)
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

}
