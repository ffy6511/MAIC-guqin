//
//  CustomTabBar.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import SwiftUI
import UIKit // 确保导入，如果 CustomTabBarItem 在同一文件

struct CustomTabBar: View {
    @EnvironmentObject var appSettings: AppSettings // 注入 AppSettings 实例
    
    @Binding var selectedIndex: Int
    let items: [(icon: String, selectedIcon: String, title: String)]

    var body: some View {
        HStack {
            ForEach(items.indices, id: \.self) { idx in
                CustomTabBarItem(
                    icon: items[idx].icon,
                    selectedIcon: items[idx].selectedIcon,
                    title: items[idx].title,
                    isSelected: selectedIndex == idx
                ) {
                    selectedIndex = idx
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 4)
        .background(.ultraThinMaterial.opacity(0.9))
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2) // 轻微阴影
        .padding(.horizontal) // 留出左右边距，让 TabBar 看起来不顶满屏幕宽度
        .padding(.bottom, UIDevice.current.hasNotch ? 0 : 5) // 底部安全区域，仅在非刘海屏设备上加额外填充
    }
}

// 辅助扩展，检查设备是否有刘海屏 (以便更好地控制底部安全区)
extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
}
