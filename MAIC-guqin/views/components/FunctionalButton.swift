//
// FunctionalButton.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/24.
//

import SwiftUI

struct FunctionalButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            // 采用 ZStack + VStack 的组合，确保内容定位和弹性
            ZStack(alignment: .topLeading) { // 背景和图标
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("BrandPrimary").opacity(0.7))
                    .shadow(radius: 4)

                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0)) // 图标定位
                    .shadow(radius: 2)
            }
            .overlay( // 使用 overlay 将标题放在 ZStack 的底部
                VStack {
                    Spacer() // 将标题推到底部
                    HStack {
                        Spacer() // 将标题推到右侧
                        Text(title)
                            .font(.caption)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7) // 确保在空间不足时缩小
                            .foregroundColor(Color.white.opacity(0.8))
                            .shadow(radius: 2)
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)) // 标题内边距
                    }
                }
            )
            // 关键：让 FunctionalButton 自身具备填充父容器的能力，并保持宽高比
            .aspectRatio(3/2, contentMode: .fit) // 按钮整体保持 3:2 比例，并适应可用空间
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 允许其最大化填充 GridItem 提供的空间
            .padding(.horizontal,8)
        }
    }
}

struct FunctionalButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 在预览中放置在一个明确尺寸的容器中，以观察其行为
            FunctionalButton(title: "练习模式", icon: "music.note.list") { print("Action") }
                .frame(width: 150, height: 100) // 模拟一个 3:2 的父容器
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("FunctionalButton (3:2)")

            FunctionalButton(title: "音阶模式", icon: "scale.3d") { print("Action") }
                .frame(width: 200) // 模拟一个只给宽度约束的父容器
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("FunctionalButton (Width only)")
        }
    }
}
