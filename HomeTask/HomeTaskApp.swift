//
//  HomeTaskApp.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData

@main
struct HomeTaskApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Stock.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            StockListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
