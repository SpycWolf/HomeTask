//
//  ShoppingView.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/22.
//

import SwiftUI

struct ShoppingView: View {
    @ObservedObject var viewModel: ShoppingViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.items.isEmpty {
                    ShoppingEmptyView()
                }
                ForEach($viewModel.items) { $item in
                    ShoppingRowView(item: item,
                                    incrementAction: { viewModel.increment(item: item) },
                                    decrementAction: { viewModel.decrement(item: item) },
                                    purchaseAction: { viewModel.purchase(item: item) })
                }
                .onDelete { indexSet in
                    viewModel.deleteItem(indexSet: indexSet)
                }
            }
            .navigationTitle("買い物一覧")
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor(Color.bgwhite)
                viewModel.onAppear()
            }
        }
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(viewModel: .init(useCase: ShoppingPreViewUseCaseImpl(repository: ShoppingRepositoryImpl.shared)))
    }
}
