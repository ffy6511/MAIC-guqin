//
//  SettingsView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/27.
//
// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings // 注入 AppSettings 实例
    
    var body: some View {
        Form {
            Section("外观显示") {
                Picker("主题", selection: $appSettings.settings.selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.displayName).tag(theme)
                    }
                }
                
                if UIApplication.shared.supportsAlternateIcons {
                    Picker("应用图标", selection: $appSettings.settings.selectedAppIcon) {
                        ForEach(AppIcon.allCases) { icon in
                            Label(icon.displayName, systemImage: icon.rawValue == "AppIcon" ? "app.fill" : "apps.iphone")
                                .tag(icon)
                        }
                    }
                }
            }
            
            Section("个人资料") {
                TextField("用户名", text: $appSettings.settings.username)
                TextField("昵称", text: $appSettings.settings.nickname)
                Picker("性别", selection: $appSettings.settings.gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                TextField("个性签名", text: $appSettings.settings.signature, axis: .vertical)
                    .lineLimit(3)
            }
            
            Section("通用设置") {
                Toggle("触控反馈", isOn: $appSettings.settings.hapticFeedbackEnabled)
                if appSettings.settings.hapticFeedbackEnabled {
                    Button("测试触控反馈") {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                }
            }
            
            Section("关于") {
                Text("您已使用本产品 \(appSettings.settings.appUsageDays) 天")
            }
        }
        .navigationTitle("设置")
        .preferredColorScheme(appSettings.settings.selectedTheme.colorScheme)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(AppSettings()) // 预览时提供 AppSettings 实例
        }
    }
}
