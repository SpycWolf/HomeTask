//
//  StockEmptyRow.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/16.
//

import SwiftUI

struct StockEmptyRow: View {
    var body: some View {
        Text("登録アイテムがありません")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .listRowInsets(EdgeInsets(top: 24,
                                      leading: 0,
                                      bottom: 8,
                                      trailing: 0))
    }
}

struct StockEmptyRow_Previews: PreviewProvider {
    static var previews: some View {
        StockEmptyRow()
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
