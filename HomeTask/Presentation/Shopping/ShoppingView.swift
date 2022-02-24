//
//  ShoppingView.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/22.
//

import SwiftUI

struct ShoppingView: View {
    @ObservedObject var viewModel: ShoppingViewModel
    
    @State private var isPresentingActionSheet = false
    
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
                        .onTapGesture {
                            viewModel.purchase(item: item)
                        }
                }
                .onDelete { indexSet in
                    viewModel.deleteItem(indexSet: indexSet)
                }
            }
            .navigationTitle("買い物一覧")
            .toolbar {
                if !viewModel.items.isEmpty {
                    Button(action: {
                        isPresentingActionSheet = true
                    }) {
                        Text("購入済みを削除")
                    }
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor(Color.bgwhite)
                viewModel.onAppear()
            }
            .actionSheet(isPresented: $isPresentingActionSheet) {
                ActionSheet(title: Text("購入した数量をストックに反映しますか？"),
                            buttons: [
                                .default(Text("ストックに反映して削除")) {
                                    viewModel.deleteAndReflect()
                                },
                                .destructive(Text("削除だけ行う")) {
                                    viewModel.deleteItems()
                                },
                                .cancel()
                            ])
            }
        }
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(viewModel: .init(useCase: ShoppingViewUseCaseImpl(repository: ShoppingRepositoryImpl.shared)))
        ShoppingView(viewModel: .init(useCase: ShoppingPreViewUseCaseImpl(repository: ShoppingRepositoryImpl.shared)))
    }
}
