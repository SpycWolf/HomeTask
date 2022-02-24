//
//  ShoppingUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingViewUseCase {
    func items() -> [ShoppingModel]
    func delete(id: UUID)
    func delete(ids: [UUID])
    func increment(id: UUID)
    func decrement(id: UUID)
    func purchase(id: UUID, purchased: Bool)
    func updateAmount(stockId: UUID, amount: Int)
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
    
    func delete(id: UUID) {
        repository.delete(id: id)
    }
    
    func delete(ids: [UUID]) {
        repository.delete(ids: ids)
    }
    
    func increment(id: UUID) {
        repository.increment(id: id)
    }
    
    func decrement(id: UUID) {
        repository.decrement(id: id)
    }
    
    func purchase(id: UUID, purchased: Bool) {
        repository.purchase(id: id, purchased: purchased)
    }
    
    func updateAmount(stockId: UUID, amount: Int) {
        stockUseCase.updateAmount(id: stockId, amount: amount)
    }
}

struct ShoppingPreViewUseCaseImpl: ShoppingViewUseCase {
    private let repository: ShoppingRepository
    private let stockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl.shared)
    
    init(repository: ShoppingRepository) {
        self.repository = repository
    }
    
    func items() -> [ShoppingModel] {
        ShoppingModel.sample()
    }
    
    func delete(id: UUID) {
        repository.delete(id: id)
    }
    
    func delete(ids: [UUID]) {
        repository.delete(ids: ids)
    }
    
    func increment(id: UUID) {
        repository.increment(id: id)
    }
    
    func decrement(id: UUID) {
        repository.decrement(id: id)
    }
    
    func purchase(id: UUID, purchased: Bool) {
        repository.purchase(id: id, purchased: purchased)
    }
    
    func updateAmount(stockId: UUID, amount: Int) {
        stockUseCase.updateAmount(id: stockId, amount: amount)
    }
}
