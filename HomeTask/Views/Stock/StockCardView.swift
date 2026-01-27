//
//  StockCardView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

struct StockCardView: View {
    @Bindable var stock: Stock
    
    var body: some View {
        VStack(spacing: 8) {
            // 画像エリア
            imageSection
            
            // 情報エリア
            VStack(spacing: 4) {
                Text(stock.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(height: 40)
                
                // 個数と増減ボタン
                HStack(spacing: 8) {
                    Button {
                        if stock.quantity > 0 {
                            stock.quantity -= 1
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(stock.quantity > 0 ? AppColors.primary : AppColors.secondary.opacity(0.5))
                    }
                    .buttonStyle(.plain)
                    .disabled(stock.quantity <= 0)
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(AppColors.quantityColor(for: stock.quantity))
                            .frame(width: 8, height: 8)
                        Text("\(stock.quantity)")
                            .font(.headline)
                            .foregroundStyle(AppColors.textPrimary)
                    }
                    .frame(minWidth: 40)
                    
                    Button {
                        stock.quantity += 1
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(AppColors.primary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var imageSection: some View {
        Group {
            if let imageData = stock.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()
            } else {
                Rectangle()
                    .fill(AppColors.background)
                    .frame(height: 100)
                    .overlay {
                        Image(systemName: "shippingbox")
                            .font(.largeTitle)
                            .foregroundStyle(AppColors.secondary.opacity(0.5))
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding([.top, .horizontal], 8)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Stock.self, configurations: config)
    let stock = Stock(name: "トイレットペーパー", quantity: 3)
    container.mainContext.insert(stock)
    
    return StockCardView(stock: stock)
        .frame(width: 170)
        .modelContainer(container)
}
