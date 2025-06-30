//
//  NavigableButtonStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/30.
//

import SwiftUI

struct NavigableButtonStyle: ButtonStyle {
    @EnvironmentObject var appSettings: AppSettings

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                RoundedRectangle(cornerRadius: 16)
                    // 根据按钮是否被按下改变背景颜色
                    .fill(configuration.isPressed ? Color.brandPrimary : Color.gray.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            }
            // 根据按钮是否被按下改变前景色
            .foregroundColor(configuration.isPressed ? .white : Color.textSecondary)
            // 按下时的缩放效果
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            // **核心改变：移除 onLongPressGesture，使用 onChange 监听 isPressed 变化来触发触觉反馈**
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed && appSettings.settings.hapticFeedbackEnabled {
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                }
            }
            // 移除 .contentShape(Rectangle())，通常不是必须的，有时可能引起不必要的复杂性
    }
}

// 预览 (可选，用于单独查看样式)
struct NavigableButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            VStack {
                Image(systemName: "cloud.fill")
                Text("环境系统")
            }
            .padding()
            .frame(width: 100, height: 80)
        }
        .buttonStyle(NavigableButtonStyle())
        .environmentObject(AppSettings()) // 为预览提供 AppSettings
        .previewLayout(.sizeThatFits)
    }
}
