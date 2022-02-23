//
//  CartUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingUseCase {
    func addCart(id: UUID, amount: Int, stockId: UUID, stock: StockEntity)
}

struct ShoppingUseCaseImpl: ShoppingUseCase {
    let repository: ShoppingRepository
    
    init(repository: ShoppingRepository) {
        self.repository = repository
    }
    
    func addCart(id: UUID, amount: Int, stockId: UUID, stock: StockEntity) {
        repository.createOrUpdate(id: id, amount: amount, stockId: stockId, stock: stock)
    }
}
