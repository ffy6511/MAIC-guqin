//
//  RoomView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI
import UIKit // 用于触控反馈
import Combine // 用于订阅 RoomBackgroundManager

struct RoomView: View {
    @StateObject private var backgroundManager = RoomBackgroundManager()
    
    // 控制模态视图的显示状态
    @State private var showingBackgroundSettings: Bool = false

    // MARK: - 局部动画状态 (由 RoomBackgroundManager 驱动)
    // RoomView 现在将使用 RoomBackgroundManager 内部的帧索引
    // 但为了确保视图在帧变化时更新，我们需要订阅或直接访问
    // 为了简化，我们假设 RoomBackgroundManager 会负责更新其内部的 currentForegroundFrameIndex 等
    // 并在其 currentForegroundImageName 等计算属性中提供当前图片。

    var body: some View {
        ZStack {
            // 1. 远处环境层
            // 使用 RoomBackgroundManager 提供的当前图片名
            if !backgroundManager.currentDistantImageName.isEmpty {
                Image(backgroundManager.currentDistantImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                Color.gray.opacity(0.1).ignoresSafeArea() // 占位背景
            }


            // 2. 前景主体层
            // 使用 RoomBackgroundManager 提供的当前图片名
            if !backgroundManager.currentForegroundImageName.isEmpty {
                Image(backgroundManager.currentForegroundImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                EmptyView()
            }


            // 3. 天气效果层 - 根据 weatherEffectType 渲染粒子效果或图片
            // 只有当全局动画启用时才显示粒子效果
            if backgroundManager.isGlobalAnimationEnabled {
                switch backgroundManager.currentWeatherEffectType {
                case .none:
                    EmptyView() // 无天气效果
                case .rain:
                    RainEffectView(isEnabled: backgroundManager.isGlobalAnimationEnabled, animationScale: 0.5) // 预览时可以调低速度或密度
                        .allowsHitTesting(false) // 防止粒子视图捕获点击
                case .snow:
                    SnowEffectView(isEnabled: true, animationScale: 1.0)
                        .allowsHitTesting(false)

                }
            }
            
            // ... RoomView 的其他 UI 元素，例如古琴、顶部设置按钮等 ...
            
            // 下方的三个按钮区域
            VStack {
                Spacer() // 将按钮推到底部
                HStack {
                    // 第一个按钮：“环境系统” - 触发模态视图
                    Button(action: {
                        showingBackgroundSettings = true
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                    }) {
                        VStack {
                            Image(systemName: "cloud.fill") // 示例图标
                            Text("环境系统")
                        }
                    }
                    .frame(maxWidth: .infinity) // 让按钮占据等宽空间

                    // 第二个按钮：“情景录制”
                    Button(action: { /* ... */ }) {
                        VStack {
                            Image(systemName: "mic.fill")
                            Text("情景录制")
                        }
                    }
                    .frame(maxWidth: .infinity)

                    // 第三个按钮：“多人琴室”
                    Button(action: { /* ... */ }) {
                        VStack {
                            Image(systemName: "person.3.fill")
                            Text("多人琴室")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .padding(.bottom) // 底部填充
                .background(.ultraThinMaterial) // 玻璃拟态效果
                .cornerRadius(10) // 圆角
                .shadow(radius: 5) // 阴影
            }
        }
        // 当视图出现和消失时控制 RoomBackgroundManager 的动画计时器
        .onAppear {
            backgroundManager.setupAnimationTimers()
        }
        .onDisappear {
            backgroundManager.stopAllTimers()
        }
        // ！！！重要：将 backgroundManager 作为 EnvironmentObject 传递给模态弹出的 RoomBackgroundSettingsView ！！！
        .sheet(isPresented: $showingBackgroundSettings) {
            RoomBackgroundSettingsView()
                .environmentObject(backgroundManager) // 将 RoomBackgroundManager 注入到设置视图
        }
    }
}

// Preview
struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
            // 如果 RoomView 不依赖 AppSettings，这里就不需要 .environmentObject(AppSettings())
            // 如果需要，比如你的触控反馈需要检查 AppSettings.hapticFeedbackEnabled，那就加回来
            // .environmentObject(AppSettings())
    }
}
