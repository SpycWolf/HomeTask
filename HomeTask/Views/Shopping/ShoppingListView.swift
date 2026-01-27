//
//  ShoppingListView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var stocks: [Stock]
    @Query private var shoppingLists: [ShoppingList]
    
    @AppStorage("shoppingThreshold") private var threshold: Int = 2
    @State private var showingThresholdSetting = false
    
    private var currentList: ShoppingList? {
        shoppingLists.first
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 抽出ボタン
                extractButton
                    .padding()
                
                // リスト表示
                if let list = currentList, !list.items.isEmpty {
                    listContent(list: list)
                } else {
                    emptyStateView
                }
            }
            .background(AppColors.background)
            .navigationTitle("買い物リスト")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingThresholdSetting = true
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(AppColors.primary)
                    }
                }
            }
            .sheet(isPresented: $showingThresholdSetting) {
                ThresholdSettingView()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var extractButton: some View {
        Button {
            extractShoppingList()
        } label: {
            HStack {
                Image(systemName: "line.3.horizontal.decrease.circle")
                Text("\(threshold)個以下を抽出")
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppColors.primary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private func listContent(list: ShoppingList) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // 最終更新日時
            Text("最終更新: \(list.createdAt, format: .dateTime.month().day().hour().minute())")
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.horizontal)
                .padding(.bottom, 8)
            
            List {
                ForEach(list.items.sorted { $0.quantity < $1.quantity }) { stock in
                    NavigationLink {
                        StockDetailView(stock: stock)
                    } label: {
                        HStack {
                            Circle()
                                .fill(AppColors.quantityColor(for: stock.quantity))
                                .frame(width: 10, height: 10)
                            
                            Text(stock.name)
                                .foregroundStyle(AppColors.textPrimary)
                            
                            Spacer()
                            
                            Text("\(stock.quantity)個")
                                .foregroundStyle(AppColors.textSecondary)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView {
            Label("買い物リストがありません", systemImage: "cart")
        } description: {
            Text("「\(threshold)個以下を抽出」ボタンで\n買い物リストを作成しましょう")
        }
        .frame(maxHeight: .infinity)
    }
    
    // MARK: - Actions
    
    private func extractShoppingList() {
        // 1. しきい値以下のストックを抽出
        let lowStockItems = stocks.filter { $0.quantity <= threshold }
        
        // 2. 既存のShoppingListを削除
        for list in shoppingLists {
            modelContext.delete(list)
        }
        
        // 3. 新しいリストを作成・保存
        let newList = ShoppingList(items: lowStockItems)
        modelContext.insert(newList)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Stock.self, ShoppingList.self, configurations: config)
    
    // サンプルデータ
    let samples = [
        Stock(name: "トイレットペーパー", quantity: 1),
        Stock(name: "ティッシュ", quantity: 0),
        Stock(name: "洗剤", quantity: 5),
    ]
    for sample in samples {
        container.mainContext.insert(sample)
    }
    
    return ShoppingListView()
        .modelContainer(container)
}
