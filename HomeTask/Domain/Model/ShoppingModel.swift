//
//  ShoppingModel.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import SwiftUI

struct ShoppingModel: Identifiable, Codable {
    var id: UUID
    var amount: Int
    var date: Date
    var purchased: Bool
    var stock: StockModel
    
    init() {
        id = UUID()
        amount = 0
        date = Date()
        purchased = false
        stock = StockModel()
    }
    
    init(id: UUID = UUID(), amount: Int, date: Date = Date(), purchased: Bool = false, stock: StockModel) {
        self.id = id
        self.amount = amount
        self.date = date
        self.purchased = purchased
        self.stock = stock
    }
}

extension ShoppingModel {
    static func sample() -> [ShoppingModel] {
        [ShoppingModel(amount: 1, stock: StockModel.sample()[0]),
         ShoppingModel(amount: 1, stock: StockModel.sample()[1]),
         ShoppingModel(amount: 1, stock: StockModel.sample()[2]),
         ShoppingModel(amount: 1, stock: StockModel.sample()[3]),
         ShoppingModel(amount: 1, stock: StockModel.sample()[4]),
         ShoppingModel(amount: 1, stock: StockModel.sample()[5])]
    }
}
