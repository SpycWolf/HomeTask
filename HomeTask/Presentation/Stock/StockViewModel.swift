//
//  StockViewModel.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/14.
//

import Foundation
import CoreData
import SwiftUI

class StockViewModel: ObservableObject {
    @Published var stocks: [StockModel] = []
    
    private let useCase: StockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl.shared)
    
    func onAppear() {
        fetchStocks()
    }
    
    func newStock() -> StockModel {
        StockModel()
    }
    
    func add(stock: StockModel) {
        useCase.createOrUpdate(id: stock.id, title: stock.title, memo: stock.memo, amount: stock.amount, limit: stock.limit)
        fetchStocks()
    }
    
    func deleteStock(indexSet: IndexSet) {
        guard let index = indexSet.first, stocks.indices.contains(index) else { return }
        useCase.delete(id: stocks[index].id)
        fetchStocks()
    }
    
    func increment(stock: StockModel) {
        useCase.increment(id: stock.id)
        fetchStocks()
    }
    
    func decrement(stock: StockModel) {
        useCase.decrement(id: stock.id)
        fetchStocks()
    }
    
    func addBag() {
        print("called addBag")
    }
    
    private func fetchStocks() {
        stocks = useCase.stocks()
    }
}
