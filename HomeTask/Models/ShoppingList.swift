//
//  ShoppingList.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import Foundation
import SwiftData

@Model
final class ShoppingList {
    var createdAt: Date
    @Relationship(deleteRule: .nullify)
    var items: [Stock]
    
    init(items: [Stock] = [], createdAt: Date = Date()) {
        self.items = items
        self.createdAt = createdAt
    }
}
