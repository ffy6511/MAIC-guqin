//
//  CardPressEffectStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/1.
//

// CardPressEffectStyle.swift
import SwiftUI

struct CardPressEffectStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label // 被应用样式的视图内容
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0) // 按下时缩小
            .shadow(
                color: configuration.isPressed ? .black.opacity(0.1) : .black.opacity(0.2), // 按下时阴影变淡
                radius: configuration.isPressed ? 5 : 10, // 按下时阴影半径变小
                x: 0,
                y: configuration.isPressed ? 2 : 5 // 按下时阴影Y轴偏移变小
            )
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed) // 添加动画效果
    }
}
