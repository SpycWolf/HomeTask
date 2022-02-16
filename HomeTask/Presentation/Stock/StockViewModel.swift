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
    private let useCase: StockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl())
    
    @Published private(set) var stocks: [StockModel] = []
    
    func onAppear() {
        stocks = useCase.stocks()
    }
    
    func addStock(title: String, memo: String?, amount: Int, limit: Int) {
        useCase.add(title: title, memo: memo, amount: amount, limit: limit)
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
