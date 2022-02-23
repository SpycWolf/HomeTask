//
//  ShoppingUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingViewUseCase {
    func items() -> [ShoppingModel]
    func createOrUpdate(id: UUID, amount: Int, stockId: UUID)
    func delete(id: UUID)
    func increment(id: UUID)
    func decrement(id: UUID)
}

struct ShoppingViewUseCaseImpl: ShoppingViewUseCase {
    private let repository: ShoppingRepository
    private let stockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl.shared)
    
    init(repository: ShoppingRepository) {
        self.repository = repository
    }
    
    func items() -> [ShoppingModel] {
        repository.items().map { ShoppingTranslator().translate($0) }
    }
    
    func createOrUpdate(id: UUID, amount: Int, stockId: UUID) {
        let stock = stockUseCase.fetch(by: id)
        repository.createOrUpdate(id: id, amount: amount, stockId: stockId, stock: stock)
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
