//
//  UserSetting.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/27.
//

import SwiftUI
import UIKit    

// 主题
enum AppTheme: String, Codable, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case system = "System Default"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .light: return "浅色模式"
        case .dark: return "深色模式"
        case .system: return "跟随系统"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}

// 性别
enum Gender: String, Codable, CaseIterable, Identifiable {
    case male = "男"
    case female = "女"
    case preferNotToSay = "不愿透露"
    
    var id: String { self.rawValue }
}

// 应用图标选择
enum AppIcon: String, Codable, CaseIterable, Identifiable {
    case primary = "AppIcon" // 主图标的名称
    case guqinIcon = "GuqinIcon" // 备用图标的名称
    case classicIcon = "ClassicIcon" // 另一个备用图标
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .primary: return "默认图标"
        case .guqinIcon: return "古琴图标"
        case .classicIcon: return "经典图标"
        }
    }
    
    // TODO：这里的 setAsCurrent() 方法是 AppIcon 枚举的"实现"部分，后续可以考虑升级
    func setAsCurrent() {
        guard UIApplication.shared.alternateIconName != self.rawValue else { return }
        
        let iconName: String? = (self == .primary) ? nil : self.rawValue
        
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("设置应用图标失败: \(error.localizedDescription)")
            } else {
                print("应用图标已成功设置为: \(self.displayName)")
            }
        }
    }
}


// MARK:  UserSetting Struct

struct UserSetting: Codable {
    // 外观显示相关
    var selectedTheme: AppTheme = .system
    var selectedAppIcon: AppIcon = .primary
    
    // 用户信息
    var username: String = "用户"
    var nickname: String = "我的古琴"
    var gender: Gender = .preferNotToSay
    var signature: String = "相逢有酒且教斟，高山流水遇知音"
    
    // 触控反馈
    var hapticFeedbackEnabled: Bool = true
    
    // 使用天数
    var appUsageDays: Int = 0
    // lastUsageDate 不应该暴露在 UserSetting 之外，它是 AppSettings 内部的管理状态
     var lastUsageDate: Date?
}
