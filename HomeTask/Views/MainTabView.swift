//
//  MainTabView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        TabView {
            StockListView()
                .tabItem {
                    Label("ストック", systemImage: "shippingbox")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("買い物", systemImage: "cart")
                }
        }
        .tint(AppColors.primary)
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [Stock.self, ShoppingList.self], inMemory: true)
}
