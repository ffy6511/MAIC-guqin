//
//  MainView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首页", systemImage:
                            "house")
                }
            
            RoomView()
                .tabItem{
                    Label("琴室", systemImage: "music.note.house")
                }

            AppreciationView()
                .tabItem {
                    Label("鉴赏", systemImage: "music.quarternote.3")
                }
            SettingView()
                .tabItem{
                    Label("我的",systemImage: "person")
                }
            
        }
    }
}

#Preview {
    MainView()
}
