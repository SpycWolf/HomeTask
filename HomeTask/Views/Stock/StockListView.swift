//
//  StockListView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

struct StockListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var stocks: [Stock]
    
    @AppStorage("stockViewMode") private var viewMode: String = ViewMode.list.rawValue
    @State private var sortOption: SortOption = .name
    @State private var showingAddSheet = false
    
    private var currentViewMode: ViewMode {
        ViewMode(rawValue: viewMode) ?? .list
    }
    
    private var sortedStocks: [Stock] {
        switch sortOption {
        case .name:
            return stocks.sorted { $0.name < $1.name }
        case .quantity:
            return stocks.sorted { $0.quantity < $1.quantity }
        }
    }
    
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                if stocks.isEmpty {
                    emptyStateView
                } else {
                    switch currentViewMode {
                    case .list:
                        stockListView
                    case .grid:
                        stockGridView
                    }
                }
            }
            .navigationTitle("ストック一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 16) {
                        sortMenu
                        viewModeButton
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(AppColors.primary)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddStockView()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var emptyStateView: some View {
        ContentUnavailableView {
            Label("ストックがありません", systemImage: "shippingbox")
        } description: {
            Text("右上の + ボタンから\n新しいストックを登録しましょう")
        } actions: {
            Button("ストックを追加") {
                showingAddSheet = true
            }
            .buttonStyle(.borderedProminent)
            .tint(AppColors.primary)
        }
    }
    
    private var stockListView: some View {
        List {
            ForEach(sortedStocks) { stock in
                NavigationLink {
                    StockDetailView(stock: stock)
                } label: {
                    StockRowView(stock: stock)
                }
            }
            .onDelete(perform: deleteStocks)
        }
    }
    
    private var stockGridView: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 12) {
                ForEach(sortedStocks) { stock in
                    NavigationLink {
                        StockDetailView(stock: stock)
                    } label: {
                        StockCardView(stock: stock)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(AppColors.background)
    }
    
    private var viewModeButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewMode = currentViewMode == .list ? ViewMode.grid.rawValue : ViewMode.list.rawValue
            }
        } label: {
            Image(systemName: currentViewMode == .list ? ViewMode.grid.icon : ViewMode.list.icon)
                .foregroundStyle(AppColors.primary)
        }
    }
    
    private var sortMenu: some View {
        Menu {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button {
                    sortOption = option
                } label: {
                    HStack {
                        Text(option.rawValue)
                        if sortOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Label("並び替え", systemImage: "arrow.up.arrow.down")
                .foregroundStyle(AppColors.primary)
        }
    }
    
    // MARK: - Actions
    
    private func deleteStocks(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let stock = sortedStocks[index]
                modelContext.delete(stock)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Stock.self, configurations: config)
    
    // サンプルデータ
    let samples = [
        Stock(name: "トイレットペーパー", quantity: 5),
        Stock(name: "ティッシュ", quantity: 2),
        Stock(name: "洗剤", quantity: 0),
    ]
    for sample in samples {
        container.mainContext.insert(sample)
    }
    
    return StockListView()
        .modelContainer(container)
}
