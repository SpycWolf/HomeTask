//
//  HomeTaskApp.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/12.
//

import SwiftUI

@main
struct HomeTaskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(">>> \(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true))")
        return true
    }
}
