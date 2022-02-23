//
//  StockViewModel.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/14.
//

import CoreData
import SwiftUI

class StockViewModel: ObservableObject {
    @Published var stocks: [StockModel] = []

    let useCase: StockViewUseCase
    
    init(useCase: StockViewUseCase) {
        self.useCase = useCase
    }
    
    func onAppear() {
        fetchStocks()
    }
    
    func newStock() -> StockModel {
        useCase.newStock()
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
    
    func addCart(stock: StockModel) {
        useCase.addCart(id: UUID(), amount: 1, stockId: stock.id)
    }
    
    private func fetchStocks() {
        stocks = useCase.stocks()
    }
}
