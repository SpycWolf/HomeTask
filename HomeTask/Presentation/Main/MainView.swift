//
//  MainView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct MainView: View {
    @Binding var stocks: [Stock]
    
    var body: some View {
        List {
            ForEach($stocks) { $stock in
                MainListView(stock: $stock)
            }
        }
        .navigationTitle("ストック一覧")
        .background(Color.red)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(stocks: .constant(Stock.sample()))
    }
}
