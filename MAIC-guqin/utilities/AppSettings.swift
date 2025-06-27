//
// AppSettings.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/27.
//

import SwiftUI
import Foundation

class AppSettings: ObservableObject {
    // 使用 @AppStorage 存储编码后的 UserSetting 数据
    @AppStorage("userSettingsData") private var _userSettingsData: Data?

    // 实际被视图绑定的设置实例
    @Published var settings: UserSetting = UserSetting() { // 提供一个默认值
        didSet {
            // 当 settings 改变时，编码并保存到 UserDefaults
            if let encoded = try? JSONEncoder().encode(settings) {
                // 现在我们可以安全地通过 _userSettingsData.wrappedValue 来写入
                _userSettingsData = encoded
            }
            // 处理应用图标的设置
            settings.selectedAppIcon.setAsCurrent()
        }
    }
    
    // 用于内部管理使用天数的辅助变量
    @AppStorage("lastUsageDate") private var lastUsageDate: Date?

    init() {
        // 在 init() 中，所有存储属性（包括 _userSettingsData 和 settings）现在都有了初始值。

        // 尝试从 UserDefaults 加载实际的设置数据
        if let data = _userSettingsData, // <<-- 更改点2：直接访问 _userSettingsData
           let decodedSettings = try? JSONDecoder().decode(UserSetting.self, from: data) {
            // 只有当成功解码时，才更新 settings。
            // 这会触发 didSet，将新的设置保存回 UserDefaults，并更新图标。
            self.settings = decodedSettings
        }
        updateUsageDays()
    }
    
    // MARK: - Usage Tracking Logic
    private func updateUsageDays() {
        let now = Date()
        let calendar = Calendar.current
        
        if let lastDate = lastUsageDate {
            if !calendar.isDate(lastDate, inSameDayAs: now) {
                if let yesterday = calendar.date(byAdding: .day, value: -1, to: now),
                   calendar.isDate(lastDate, inSameDayAs: yesterday) {
                    settings.appUsageDays += 1
                } else {
                    settings.appUsageDays = 1
                }
            }
        } else {
            settings.appUsageDays = 1
        }
        lastUsageDate = now
    }
    
    // 用于测试
    func simulateDayChange() {
        if let lastDate = lastUsageDate {
            lastUsageDate = Calendar.current.date(byAdding: .day, value: -2, to: lastDate)
        } else {
            lastUsageDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        }
        updateUsageDays()
    }
}
