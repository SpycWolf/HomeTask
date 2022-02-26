//
//  StockUseCase.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

protocol StockUseCase {
    func fetch(by id: UUID) -> StockEntity
    func updateAmount(id: UUID, amount: Int)
}

struct StockUseCaseImpl: StockUseCase {
    let repository: StockRepository
    
    init(repository: StockRepository) {
        self.repository = repository
    }
    
    func fetch(by id: UUID) -> StockEntity {
        repository.stock(by: id)
    }
    
    func updateAmount(id: UUID, amount: Int) {
        repository.updateAmount(id: id, amount: amount)
    }
    
}
