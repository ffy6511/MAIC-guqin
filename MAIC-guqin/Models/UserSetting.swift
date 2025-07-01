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

// 头像类型
enum AvatarType: String, Codable, CaseIterable, Identifiable {
    case systemDefault = "system_default"
    case custom = "custom"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .systemDefault: return "系统默认"
        case .custom: return "自定义头像"
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
    
    // 头像相关 - 新设计
    var avatarType: AvatarType = .systemDefault  // 头像类型
    var customAvatarImageData: Data? = nil       // 自定义头像数据
    
    // 触控反馈
    var hapticFeedbackEnabled: Bool = true
    
    // 使用天数
    var appUsageDays: Int = 0
    var lastUsageDate: Date?
    
    // MARK: - 头像相关的便利方法
    
    /// 设置为系统默认头像
    mutating func setSystemDefaultAvatar() {
        self.avatarType = .systemDefault
        self.customAvatarImageData = nil
    }
    
    /// 设置自定义头像
    mutating func setCustomAvatar(from image: UIImage?) {
        if let image = image {
            // 压缩图片以减少存储空间
            let maxSize: CGFloat = 300
            let resizedImage = image.resized(to: CGSize(width: maxSize, height: maxSize))
            self.customAvatarImageData = resizedImage.jpegData(compressionQuality: 0.8)
            self.avatarType = .custom
        } else {
            // 如果传入 nil，回退到系统默认
            setSystemDefaultAvatar()
        }
    }
    
    /// 获取当前头像的 UIImage
    func getAvatarImage() -> UIImage? {
        switch avatarType {
        case .systemDefault:
            return getSystemDefaultAvatarImage()
        case .custom:
            guard let data = customAvatarImageData else {
                // 如果自定义头像数据丢失，回退到系统默认
                return getSystemDefaultAvatarImage()
            }
            return UIImage(data: data)
        }
    }
    
    /// 获取当前头像的 SwiftUI Image
    func getAvatarSwiftUIImage() -> Image {
        switch avatarType {
        case .systemDefault:
            return getSystemDefaultAvatarSwiftUIImage()
        case .custom:
            if let uiImage = getAvatarImage() {
                return Image(uiImage: uiImage)
            } else {
                // 回退到系统默认
                return getSystemDefaultAvatarSwiftUIImage()
            }
        }
    }
    
    /// 检查是否有自定义头像
    var hasCustomAvatar: Bool {
        return avatarType == .custom && customAvatarImageData != nil
    }
    
    // MARK: - 私有方法：系统默认头像
    
    private func getSystemDefaultAvatarImage() -> UIImage? {
        // 你可以返回一个默认的 UIImage，或者 nil（让 SwiftUI 处理）
        return UIImage(systemName: "person.circle.fill")
    }
    
    private func getSystemDefaultAvatarSwiftUIImage() -> Image {
        // 返回系统默认的头像图标
        return Image(systemName: "person.circle.fill")
    }
}

