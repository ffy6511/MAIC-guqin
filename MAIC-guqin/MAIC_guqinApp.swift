//
//  MAIC_guqinApp.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI
import SwiftData

@main
struct MAIC_guqinApp: App {
    
    @StateObject private var appSettings = AppSettings()
    @StateObject private var scoreDataManager = ScoreDataManager()
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // 透明背景
        navBarAppearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 28, weight: .semibold),
            .foregroundColor: UIColor(Color.brandPrimary.opacity(0.7))
        ]
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.brandPrimary.opacity(0.7))
        ]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            MainView()
                .environmentObject(appSettings)
                .environmentObject(scoreDataManager)
                .tint(Color("AccentColor")) // 全局设置导航栏颜色
        }
        .modelContainer(sharedModelContainer)
    }
}
