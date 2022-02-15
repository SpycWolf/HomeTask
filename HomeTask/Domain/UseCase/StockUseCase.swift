//
//  StockUseCase.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol StockUseCase {
    func stocks() -> [StockModel]
}

struct StockUseCaseImpl: StockUseCase {
    let repository: StockRepository
    
    init(repository: StockRepository) {
        self.repository = repository
    }
    
    func stocks() -> [StockModel] {
        repository.stocks().map { StockTranslator().translate($0) }
    }
}
