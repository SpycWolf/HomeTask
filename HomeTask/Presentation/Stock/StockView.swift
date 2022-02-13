//
//  MainView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct StockView: View {
    @Binding var stocks: [Stock]
    
    var body: some View {
        List {
            ForEach($stocks) { $stock in
                StockRowView(stock: $stock)
            }
        }
        .navigationTitle("ストック一覧")
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stocks: .constant(Stock.sample()))
    }
}
