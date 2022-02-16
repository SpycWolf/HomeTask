//
//  StockViewModel.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/14.
//

import Foundation
import CoreData
import SwiftUI

class StockViewModel: ObservableObject {
    private let useCase: StockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl.shared)
    
    @Published private(set) var stocks: [StockModel] = []
    
    func onAppear() {
        stocks = useCase.stocks()
    }
    
    func addStock(stock: StockModel) {
        useCase.add(title: stock.title, memo: stock.memo, amount: 0, limit: Int(stock.limit))
        stocks = useCase.stocks()
    }
    
    func deleteStock(stock: StockModel) {
        useCase.delete(id: stock.id)
    }
    
    func increment(stock: StockModel) {
        useCase.increment(id: stock.id)
    }
    
    func decrement(stock: StockModel) {
        useCase.delete(id: stock.id)
    }
    
    func update(stock: StockModel) {
        useCase.update(stock: stock)
    }
    
    func addBag() {
        print("called addBag")
    }
}
