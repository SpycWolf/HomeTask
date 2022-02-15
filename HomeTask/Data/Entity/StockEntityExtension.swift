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
    
    static func fetchAll() -> [StockEntity] {
        let request = NSFetchRequest<StockEntity>(entityName: "StockEntity")
        request.sortDescriptors = [.init(keyPath: \StockEntity.date, ascending: false)]
        let context = PersistenceController.shared.container.viewContext
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
}
