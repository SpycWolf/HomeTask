//
//  StockDetailView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

struct StockDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var stock: Stock
    @State private var showingEditSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 画像セクション
                imageSection
                
                // 個数セクション
                quantitySection
                
                // メモセクション
                memoSection
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("編集") {
                    showingEditSheet = true
                }
                .foregroundStyle(AppColors.primary)
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditStockView(stock: stock) {
                dismiss()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var imageSection: some View {
        Group {
            if let imageData = stock.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppColors.cardBackground)
                    .frame(height: 150)
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(AppColors.secondary)
                            Text("画像なし")
                                .font(.caption)
                                .foregroundStyle(AppColors.textSecondary)
                        }
                    }
            }
        }
    }
    
    private var quantitySection: some View {
        VStack(spacing: 12) {
            HStack {
                Label("現在個数", systemImage: "number")
                    .foregroundStyle(AppColors.textSecondary)
                Spacer()
                Circle()
                    .fill(AppColors.quantityColor(for: stock.quantity))
                    .frame(width: 12, height: 12)
            }
            
            HStack(spacing: 20) {
                Button {
                    if stock.quantity > 0 {
                        stock.quantity -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(stock.quantity > 0 ? AppColors.primary : AppColors.secondary.opacity(0.5))
                }
                .buttonStyle(.plain)
                .disabled(stock.quantity <= 0)
                
                Text("\(stock.quantity)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
                    .frame(minWidth: 60)
                
                Button {
                    stock.quantity += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(AppColors.primary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var memoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("メモ", systemImage: "note.text")
                .foregroundStyle(AppColors.textSecondary)
            
            Text(stock.memo)
                .foregroundStyle(AppColors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Stock.self, configurations: config)
    let stock = Stock(name: "トイレットペーパー", quantity: 5, memo: "12ロール入りを購入する")
    container.mainContext.insert(stock)
    
    return NavigationStack {
        StockDetailView(stock: stock)
    }
    .modelContainer(container)
}
