//
//  ShoppingEntityExtension.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import CoreData
import Foundation

extension ShoppingEntity {
    
    private static var context = PersistenceController.shared.container.viewContext
    
    static func fetchAll() -> [ShoppingEntity] {
        let request = NSFetchRequest<ShoppingEntity>(entityName: "ShoppingEntity")
        request.sortDescriptors = [.init(keyPath: \ShoppingEntity.date, ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }

    
    static func find(by id: UUID) -> ShoppingEntity? {
        let request = NSFetchRequest<ShoppingEntity>(entityName: "ShoppingEntity")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context.fetch(request).first
        } catch {
            fatalError()
        }
    }
    
    static func save() {
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    static func delete(id: UUID) {
        guard let stock = find(by: id) else { return }
        context.delete(stock)
        save()
    }
    
    static func increment(id: UUID) {
        guard let stock = find(by: id) else { return }
        stock.amount += 1
        save()
    }
    
    static func decrement(id: UUID) {
        guard let stock = find(by: id), stock.amount > 0 else { return }
        stock.amount -= 1
        save()
    }
    
    static func createOrUpdate(id: UUID, amount: Int, stockId: UUID, stock: StockEntity) {
        if find(by: id) != nil {
            update(id: id, amount: amount, stockId: stockId, stock: stock)
        } else {
            newShopping(amount: amount, stockId: stockId, stock: stock)
        }
    }
    
    static private func newShopping(amount: Int, stockId: UUID, stock: StockEntity) {
        let shopping = ShoppingEntity(context: context)
        shopping.id = UUID()
        shopping.amount = Int16(amount)
        shopping.date = Date()
        shopping.stockId = stockId
        shopping.stock = stock
        context.insert(shopping)
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    static private func update(id: UUID, amount: Int, stockId: UUID, stock: StockEntity) {
        guard let shopping = find(by: id) else { return }
        shopping.amount = Int16(amount)
        shopping.stockId = stockId
        shopping.stock = stock
        save()
    }
    
}
