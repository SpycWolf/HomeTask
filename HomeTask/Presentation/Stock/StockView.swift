//
//  MainView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct StockView: View {
    @ObservedObject var viewModel: StockViewModel
    
    @State private var isPresentingNewScrumView = false
    @State private var stockData = StockModel.Data()
    
    var body: some View {
        List {
            if viewModel.stocks.isEmpty {
                StockEmptyRow()
            }
            ForEach(viewModel.stocks) { stock in
                NavigationLink(destination: StockDetailView(stock: stock.data,
                                                            editAction: {},
                                                            deleteAction: {})) {
                    StockRowView(stock: stock,
                                 incrementAction: { viewModel.increment(stock: stock) },
                                 decrementAction: { viewModel.decrement(stock: stock) },
                                 addBagAction: viewModel.addBag)
                }
            }
        }
        .navigationTitle("ストック一覧")
        .toolbar {
            Button(action: {
                isPresentingNewScrumView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationView {
                StockEditView(stock: $stockData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("閉じる") {
                                isPresentingNewScrumView = false
                                stockData = StockModel.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("追加") {
                                let newStock = StockModel(data: stockData)
                                viewModel.addStock(stock: newStock)
                                isPresentingNewScrumView = false
                            }
                        }
                    }
            }
        }
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
