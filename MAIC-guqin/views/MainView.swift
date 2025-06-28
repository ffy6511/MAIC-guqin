//
//  MainView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI

// MainView.swift (更现代的布局方式)
struct MainView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State private var selectedTab = 0
    let tabItems = [
        (icon: "house", title: "首页"),
        (icon: "music.note.house", title: "琴室"),
        (icon: "music.quarternote.3", title: "鉴赏"),
        (icon: "person", title: "我的")
    ]

    var body: some View {
        // 使用 NavigationStack 或 NavigationView 作为顶层容器，以便拥有导航栏
        NavigationStack { // 或者 NavigationView
            ZStack { // ZStack 用于切换内容视图
                switch selectedTab {
                case 0: HomeView()
                case 1: RoomView()
                case 2: AppreciationView()
                case 3: SettingsView()
                default: EmptyView()
                }
            }
            .environmentObject(appSettings) // 注入 AppSettings 到所有内容视图
            .preferredColorScheme(appSettings.settings.selectedTheme.colorScheme)

            // 使用 safeAreaInset 将自定义 TabBar 放在底部安全区
            .safeAreaInset(edge: .bottom) {
                CustomTabBar(selectedIndex: $selectedTab, items: tabItems)
                    .environmentObject(appSettings) // 注入 AppSettings 到 CustomTabBar 及其子视图
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AppSettings()) 
}
