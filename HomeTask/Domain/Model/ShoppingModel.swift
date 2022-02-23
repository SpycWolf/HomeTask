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
    var stock: StockModel
    
    init() {
        id = UUID()
        amount = 0
        date = Date()
        stock = StockModel()
    }
    
    init(id: UUID = UUID(), amount: Int, date: Date = Date(), stock: StockModel) {
        self.id = id
        self.amount = amount
        self.date = date
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
