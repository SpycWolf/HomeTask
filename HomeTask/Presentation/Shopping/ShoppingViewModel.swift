//
//  ShoppingViewModel.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import CoreData
import SwiftUI

class ShoppingViewModel: ObservableObject {
    @Published var items: [ShoppingModel] = []
    
    private let useCase: ShoppingViewUseCase
    
    init(useCase: ShoppingViewUseCase) {
        self.useCase = useCase
    }
    
    func onAppear() {
        fetchItems()
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first, items.indices.contains(index) else { return }
        useCase.delete(id: items[index].id)
        fetchItems()
    }
    
    func deleteItems() {
        let target = items.filter { $0.purchased }
        guard !target.isEmpty else { return }
        useCase.delete(ids: target.map { $0.id })
        fetchItems()
    }
    
    func deleteAndReflect() {
        let target = items.filter { $0.purchased }
        guard !target.isEmpty else { return }
        target.forEach { item in
            useCase.updateAmount(stockId: item.stock.id, amount: item.amount)
        }
        deleteItems()
    }
    
    func increment(item: ShoppingModel) {
        useCase.increment(id: item.id)
        fetchItems()
    }
    
    func decrement(item: ShoppingModel) {
        useCase.decrement(id: item.id)
        fetchItems()
    }
    
    func purchase(item: ShoppingModel) {
        useCase.purchase(id: item.id, purchased: !item.purchased)
        fetchItems()
    }
    
    func shareItems() -> String {
        var shareItems = [String]()
        items.forEach { item in
            if item.stock.memo.isEmpty {
                shareItems.append("\(item.stock.title): \(item.amount)")
            } else {
                shareItems.append("\(item.stock.title)(\(item.stock.memo)): \(item.amount)")
            }
        }
        return shareItems.joined(separator: "\n")
    }
    
    private func fetchItems() {
        items = useCase.items()
    }
    
}
