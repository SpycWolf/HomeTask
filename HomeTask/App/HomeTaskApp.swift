//
//  HomeTaskApp.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/12.
//

import SwiftUI

@main
struct HomeTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                StockView(viewModel: .init())
//                    .environment(\.managedObjectContext,
//                                  persistenceController.container.viewContext)
            }
        }
    }
}
