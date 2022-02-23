//
//  StockModelTranslator.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

struct StockTranslator: Translator {
    func translate(_ entity: StockEntity) -> StockModel {
        StockModel(id: entity.id ?? UUID(),
                   title: entity.title ?? "",
                   memo: entity.memo ?? "",
                   amount: Int(entity.amount),
                   limit: Double(entity.limit),
                   date: entity.date ?? Date())
    }
}
