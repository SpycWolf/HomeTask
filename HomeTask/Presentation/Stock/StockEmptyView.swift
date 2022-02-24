//
//  StockEmptyRow.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/16.
//

import SwiftUI

struct StockEmptyView: View {
    var body: some View {
        Text("登録アイテムがありません")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .listRowInsets(EdgeInsets(top: 24,
                                      leading: 0,
                                      bottom: 8,
                                      trailing: 0))
            .listRowBackground(Color.clear)
    }
}

struct StockEmptyRow_Previews: PreviewProvider {
    static var previews: some View {
        StockEmptyView()
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
