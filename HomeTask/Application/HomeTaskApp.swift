//
//  HomeTaskApp.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/12.
//

import SwiftUI

@main
struct HomeTaskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    init() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                StockView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "checklist")
                    }
                ShoppingView()
                    .tabItem {
                        Image(systemName: "cart")
                    }
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(">>> \(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true))")
        return true
    }
}
