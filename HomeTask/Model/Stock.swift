//
//  ItemList.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct Stock: Identifiable, Codable {
    var id: UUID
    var title: String
    var memo: String
    var amount: Int
    var limit: Int
    var date: Date
    
    init(id: UUID = UUID(), title: String, memo: String, amount: Int, limit: Int, date: Date = Date()) {
        self.id = id
        self.title = title
        self.memo = memo
        self.amount = amount
        self.limit = limit
        self.date = date
    }
}

extension Stock {
    static func sample() -> [Stock] {
        [Stock(title: "トイレットペーパー", memo: "2倍巻き、無香料", amount: 2, limit: 0),
         Stock(title: "シャンプー", memo: "", amount: 1, limit: 0),
         Stock(title: "ボディソープ", memo: "泡タイプ、オイルインのもの", amount: 3, limit: 1)]
    }
}
