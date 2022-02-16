//
//  MainView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct StockView: View {
    @ObservedObject var viewModel: StockViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.stocks) { stock in
                StockRowView(stock: stock,
                             incrementAction: { viewModel.increment(stock: stock) },
                             decrementAction: { viewModel.decrement(stock: stock) },
                             addBagAction: viewModel.addBag)
            }
        }
        .navigationTitle("ストック一覧")
        .onAppear {
            UITableView.appearance().backgroundColor = UIColor(Color.white)
            viewModel.onAppear()
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(viewModel: .init())
    }
}
