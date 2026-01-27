//
//  StockRowView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

struct StockRowView: View {
    @Bindable var stock: Stock
    
    var body: some View {
        HStack(spacing: 12) {
            // 在庫状況インジケーター
            Circle()
                .fill(AppColors.quantityColor(for: stock.quantity))
                .frame(width: 10, height: 10)
            
            // 品名
            Text(stock.name)
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(1)
            
            Spacer()
            
            // 個数ステッパー
            HStack(spacing: 8) {
                Button {
                    if stock.quantity > 0 {
                        stock.quantity -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundStyle(stock.quantity > 0 ? AppColors.primary : AppColors.secondary.opacity(0.5))
                        .font(.title2)
                }
                .buttonStyle(.plain)
                .disabled(stock.quantity <= 0)
                
                Text("\(stock.quantity)")
                    .font(.headline)
                    .foregroundStyle(AppColors.textPrimary)
                    .frame(minWidth: 30)
                
                Button {
                    stock.quantity += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(AppColors.primary)
                        .font(.title2)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Stock.self, configurations: config)
    let stock = Stock(name: "トイレットペーパー", quantity: 3)
    container.mainContext.insert(stock)
    
    return List {
        StockRowView(stock: stock)
    }
    .modelContainer(container)
}
