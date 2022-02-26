//
//  CartUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol ShoppingUseCase {
    func addCart(amount: Int, stockId: UUID, stock: StockEntity)
}

struct ShoppingUseCaseImpl: ShoppingUseCase {
    let repository: ShoppingRepository
    
    init(repository: ShoppingRepository) {
        self.repository = repository
    }
    
    func addCart(amount: Int, stockId: UUID, stock: StockEntity) {
        repository.createOrUpdate(amount: amount, stockId: stockId, stock: stock)
    }
}
