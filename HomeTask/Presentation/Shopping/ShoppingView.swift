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
            .navigationTitle("shoppingViewTitle")
            .toolbar {
                if !viewModel.items.isEmpty {
                    Button(action: {
                        isPresentingActionSheet = true
                    }) {
                        Text("shoppingViewDelete")
                    }
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor(Color.bgwhite)
                viewModel.onAppear()
            }
            .actionSheet(isPresented: $isPresentingActionSheet) {
                ActionSheet(title: Text("shoppingViewConfirm"),
                            buttons: [
                                .default(Text("confirmReflect")) {
                                    viewModel.deleteAndReflect()
                                },
                                .destructive(Text("confirmDelete")) {
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
