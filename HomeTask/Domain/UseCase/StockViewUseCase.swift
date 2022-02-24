//
//  StockUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

protocol StockViewUseCase {
    func stocks() -> [StockModel]
    func newStock() -> StockModel
    func createOrUpdate(id: UUID, title: String, memo: String, amount: Int, limit: Double)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
    func addCart(amount: Int, stockId: UUID)
}

struct StockViewUseCaseImpl: StockViewUseCase {
    private let repository: StockRepository
    private let stockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl.shared)
    private let shoppingUseCase = ShoppingUseCaseImpl(repository: ShoppingRepositoryImpl.shared)
    
    init(repository: StockRepository) {
        self.repository = repository
    }
    
    func stocks() -> [StockModel] {
        repository.stocks().map { StockTranslator().translate($0) }
    }
    
    func newStock() -> StockModel {
        StockModel()
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
    
    func addCart(amount: Int, stockId: UUID) {
        let stock = stockUseCase.fetch(by: stockId)
        shoppingUseCase.addCart(amount: amount, stockId: stockId, stock: stock)
    }

}

struct StockPreViewUseCaseImpl: StockViewUseCase {
    private let repository: StockRepository
    private let stockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl.shared)
    private let shoppingUseCase = ShoppingUseCaseImpl(repository: ShoppingRepositoryImpl.shared)
    
    init(repository: StockRepository) {
        self.repository = repository
    }
    
    func stocks() -> [StockModel] {
        StockModel.sample()
    }
    
    func newStock() -> StockModel {
        StockModel()
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
    
    func addCart(amount: Int, stockId: UUID) {
        let stock = stockUseCase.fetch(by: stockId)
        shoppingUseCase.addCart(amount: amount, stockId: stockId, stock: stock)
    }

}
