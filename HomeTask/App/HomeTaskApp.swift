//
//  HomeTaskApp.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/12.
//

import SwiftUI

@main
struct HomeTaskApp: App {
    @State var stocks = Stock.sample()

//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(stocks: $stocks)
            }
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
