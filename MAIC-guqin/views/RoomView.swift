//
//  RoomView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

// RoomView.swift
import SwiftUI
import UIKit // 如果动画帧切换时需要触控反馈，或者其他 UIKit 元素

// 定义一个枚举
enum BackgroundAnimationMode {
    case modeA // 对应第一组图片
    case modeB // 对应第二组图片
}

struct RoomView: View {
    // 使用 @State 管理当前页面的动画状态
    @State private var isAnimationEnabled: Bool = true // 控制动画开关
    @State private var currentAnimationMode: BackgroundAnimationMode = .modeA // 控制动画模式
    @State private var currentFrameIndex: Int = 0 // 用于序列帧动画的当前帧索引

    // 假设你的两组图片数组
    let animationFramesForModeA = ["bamboo_01", "bamboo_02", "bamboo_03"] // 替换为你的图片名称
    let animationFramesForModeB = ["wave_01", "wave_02", "wave_03"] // 替换为你的图片名称

    // 可能需要一个 Timer 来控制序列帧动画
    @State private var animationTimer: Timer?

    var body: some View {
        ZStack {
            // 根据动画开关和模式显示背景
            if isAnimationEnabled {
                // 根据 currentAnimationMode 选择图片序列
                let activeFrames = (currentAnimationMode == .modeA) ? animationFramesForModeA : animationFramesForModeB

                if !activeFrames.isEmpty {
                    Image(activeFrames[currentFrameIndex]) // 显示当前帧图片
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        // 添加动画效果，例如淡入淡出，或帧切换时的平滑过渡
                        .transition(.opacity) // 简单的淡入淡出
                        .animation(.easeInOut(duration: 0.5), value: currentFrameIndex) // 动画过渡
                } else {
                    // 占位符：如果图片数组为空
                    Color.gray.opacity(0.1).ignoresSafeArea()
                }
            } else {
                // 动画关闭时显示静态背景（例如，第一组动画的第一帧或特定静态图）
                Image("static_background_image") // 替换为你动画关闭时的静态背景图
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }

            // ... RoomView 的其他 UI 元素，例如古琴、顶部设置按钮等 ...

            // 下方的三个按钮区域
            VStack {
                Spacer() // 将按钮推到底部
                HStack {
                    // 第一个按钮：“环境系统”
                    Button(action: {
                        // 切换动画模式或开关
                        isAnimationEnabled.toggle() // 示例：直接开关动画
                        // 如果是切换模式：
                        // currentAnimationMode = (currentAnimationMode == .modeA) ? .modeB : .modeA

                        // 触觉反馈 (如果需要且 RoomView 有 AppSettings 访问权限)
                        // 这里我们假设 RoomView 内部不检查 AppSettings，直接触发
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()

                        // 重新启动动画，确保从第一帧开始或同步
                        resetAndStartAnimation()
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
        // 当视图出现和消失时控制动画计时器
        .onAppear(perform: startAnimationTimer)
        .onDisappear(perform: stopAnimationTimer)
    }

    // MARK: - 动画控制方法
    private func startAnimationTimer() {
        stopAnimationTimer() // 确保旧的计时器被停止
        guard isAnimationEnabled else { return } // 只有在启用时才启动

        // 假设每 0.15 秒切换一帧
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            let activeFrames = (currentAnimationMode == .modeA) ? animationFramesForModeA : animationFramesForModeB
            guard !activeFrames.isEmpty else { return }
            currentFrameIndex = (currentFrameIndex + 1) % activeFrames.count
        }
    }

    private func stopAnimationTimer() {
        animationTimer?.invalidate()
        animationTimer = nil
    }

    private func resetAndStartAnimation() {
        currentFrameIndex = 0 // 动画重置到第一帧
        startAnimationTimer() // 重新启动计时器
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
