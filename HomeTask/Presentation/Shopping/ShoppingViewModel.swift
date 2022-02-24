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
        useCase.delete(ids: items.filter { $0.purchased }.map { $0.id })
        fetchItems()
    }
    
    func deleteAndReflect() {
        items.filter { $0.purchased }.forEach { item in
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
    
    private func fetchItems() {
        items = useCase.items()
    }
    
}
