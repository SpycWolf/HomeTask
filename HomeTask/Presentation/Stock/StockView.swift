//
//  MainView.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/13.
//

import SwiftUI

struct StockView: View {
    @ObservedObject var viewModel: StockViewModel
    
    @State private var isPresentingNewScrumView = false
    @State private var stockData = StockModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.stocks.isEmpty {
                    StockEmptyRow()
                }
                ForEach($viewModel.stocks) { $stock in
                    StockRowView(stock: stock,
                                 incrementAction: { viewModel.increment(stock: stock) },
                                 decrementAction: { viewModel.decrement(stock: stock) },
                                 addBagAction: { viewModel.addCart(stock: stock) })
                        .onTapGesture {
                            stockData = stock
                            isPresentingNewScrumView = true
                        }
                }
                .onDelete { indexSet in
                    viewModel.deleteStock(indexSet: indexSet)
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
                                    stockData = viewModel.newStock()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("保存") {
                                    viewModel.add(stock: stockData)
                                    stockData = viewModel.newStock()
                                    isPresentingNewScrumView = false
                                }
                            }
                        }
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor(Color.bgwhite)
                viewModel.onAppear()
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(viewModel: .init(useCase: StockPreViewUseCaseImpl(repository: StockRepositoryImpl.shared)))
    }
}
