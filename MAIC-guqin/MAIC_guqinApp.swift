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
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 28, weight: .semibold),
                .foregroundColor: UIColor(Color.brandPrimary)
            ]
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
        }
        .modelContainer(sharedModelContainer)
    }
}
