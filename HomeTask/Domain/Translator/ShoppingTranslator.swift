//
//  ShoppingTranslator.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import Foundation

struct ShoppingTranslator: Translator {
    func translate(_ entity: ShoppingEntity) -> ShoppingModel {
        ShoppingModel(id: entity.id ?? UUID(),
                      amount: Int(entity.amount),
                      date: entity.date ?? Date(),
                      stock: StockTranslator().translate(entity.stock ?? StockEntity()))
    }
}
