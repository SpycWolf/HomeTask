//
//  StockEntityExtension.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation
import CoreData
import UIKit

extension StockEntity {
    
    private static var context = PersistenceController.shared.container.viewContext
    
    static func fetchAll() -> [StockEntity] {
        let request = NSFetchRequest<StockEntity>(entityName: "StockEntity")
        request.sortDescriptors = [.init(keyPath: \StockEntity.date, ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    static func newStock(title: String, memo: String?, amount: Int, limit: Int) {
        let stock = StockEntity(context: context)
        stock.id = UUID()
        stock.title = title
        stock.memo = memo
        stock.amount = Int16(amount)
        stock.limit = Int16(limit)
        stock.date = Date()
        context.insert(stock)
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    static func find(by id: UUID) -> StockEntity? {
        let request = NSFetchRequest<StockEntity>(entityName: "StockEntity")
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
    
    static func deleteStock(id: UUID) {
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
        guard let stock = find(by: id) else { return }
        stock.amount -= 1
        save()
    }
    
    static func update(id: UUID, title: String, memo: String?, amount: Int, limit: Double) {
        guard let stock = find(by: id) else { return }
        stock.title = title
        stock.memo = memo
        stock.amount = Int16(amount)
        stock.limit = Int16(limit)
        stock.date = Date()
        save()
    }

}
