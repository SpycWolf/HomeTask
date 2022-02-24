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

    
    static func find(id: UUID) -> ShoppingEntity? {
        let request = NSFetchRequest<ShoppingEntity>(entityName: "ShoppingEntity")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try context.fetch(request).first
        } catch {
            fatalError()
        }
    }
    
    static func find(stockId: UUID) -> ShoppingEntity? {
        let request = NSFetchRequest<ShoppingEntity>(entityName: "ShoppingEntity")
        request.predicate = NSPredicate(format: "stockId == %@", stockId as CVarArg)
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
        guard let item = find(id: id) else { return }
        context.delete(item)
        save()
    }
    
    static func delete(ids: [UUID]) {
        ids.forEach { id in
            if let item = find(id: id) {
                context.delete(item)
                save()
            }
        }
    }
    
    static func increment(id: UUID) {
        guard let item = find(id: id) else { return }
        item.amount += 1
        save()
    }
    
    static func decrement(id: UUID) {
        guard let item = find(id: id), item.amount > 0 else { return }
        item.amount -= 1
        save()
    }
    
    static func purchase(id: UUID, purchased: Bool) {
        guard let item = find(id: id), item.amount > 0 else { return }
        item.purchased = purchased
        save()
    }
    
    static func createOrUpdate(amount: Int, stockId: UUID, stock: StockEntity) {
        if let item = find(stockId: stockId) {
            update(shopping: item, amount: amount, stockId: stockId, stock: stock)
        } else {
            newShopping(amount: amount, stockId: stockId, stock: stock)
        }
    }
    
    static private func newShopping(amount: Int, stockId: UUID, stock: StockEntity) {
        let shopping = ShoppingEntity(context: context)
        shopping.id = UUID()
        shopping.amount = Int16(amount)
        shopping.date = Date()
        shopping.purchased = false
        shopping.stockId = stockId
        shopping.stock = stock
        context.insert(shopping)
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    static private func update(shopping: ShoppingEntity, amount: Int, stockId: UUID, stock: StockEntity) {
        shopping.amount = Int16(amount)
        shopping.stockId = stockId
        shopping.stock = stock
        save()
    }
    
}
