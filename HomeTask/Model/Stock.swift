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
    var memo: String?
    var amount: Int
    var limit: Int
    var date: Date
    
    init(id: UUID = UUID(), title: String, memo: String?, amount: Int, limit: Int, date: Date = Date()) {
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
        [Stock(title: "トイレットペーパートイレットペーパートイレットペーパー", memo: "2倍巻き、無香料", amount: 2, limit: 3),
         Stock(title: "シャンプー", memo: nil, amount: 1, limit: 2),
         Stock(title: "ボディソープ", memo: "泡タイプ、オイルインのもの", amount: 3, limit: 1),
         Stock(title: "ティッシュ", memo: "薄型ボックス", amount: 6, limit: 2),
         Stock(title: "目薬", memo: nil, amount: 3, limit: 3),
         Stock(title: "コーヒーフィルター", memo: "カリタの2号", amount: 0, limit: 1),
         Stock(title: "台所洗剤", memo: "詰め替え用", amount: 2, limit: 1)]
    }
}
