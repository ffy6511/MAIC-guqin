//
//  RoomBackgroundManager.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation
import SwiftUI // 为了 Timer，以及 @Published

// RoomBackgroundManager：负责管理房间背景的当前状态和所有动画逻辑
class RoomBackgroundManager: ObservableObject {
    // @Published 属性会自动通知其观察者（例如 RoomView）当值发生变化时进行视图更新
    
    // 当前选中的背景配置。当 currentConfig 改变时，会触发 setupAnimationTimers()
    @Published var currentConfig: RoomBackgroundConfiguration {
        didSet {
            // 当背景配置发生变化时，需要重新评估并启动/停止所有相关的动画计时器。
            setupAnimationTimers()
        }
    }
    
    // 全局动画开关
    @Published var isGlobalAnimationEnabled: Bool = true {
        didSet {
            // 当全局动画开关状态改变时，也需要重新设置计时器。
            setupAnimationTimers()
        }
    }

    // 各个动画层的当前帧索引
    @Published private(set) var foregroundFrameIndex: Int = 0 // 前景动画的当前帧索引
    @Published private(set) var weatherEffectFrameIndex: Int = 0 // 天气动画的当前帧索引

    // 各个动画层的 Timer 实例
    private var foregroundTimer: Timer? // 前景动画的计时器
    private var weatherEffectTimer: Timer? // 天气动画的计时器

    // 初始化方法
    // 可以传入一个初始配置，如果未传入则使用 RoomBackgroundConfiguration 的默认配置。
    init(initialConfig: RoomBackgroundConfiguration = .defaultConfig) {
        self.currentConfig = initialConfig
        // 在管理器初始化后，立即根据当前配置和全局开关状态设置动画计时器。
        setupAnimationTimers()
    }
    
    // MARK: - 动画控制核心逻辑
    
    // 设置所有动画计时器。这是当 currentConfig 或 isGlobalAnimationEnabled 改变时调用的核心方法。
    private func setupAnimationTimers() {
        // 首先，停止所有当前正在运行的计时器，以避免重复和资源浪费。
        stopAllTimers()
        
        // 如果全局动画被禁用，则直接返回，不启动任何计时器。
        guard isGlobalAnimationEnabled else { return }

        // --- 前景动画计时器设置 ---
        // 只有当：
        // 1. 当前配置的前景元素被标记为动画（isAnimated = true）
        // 2. 该元素定义了动画速度（animationSpeed 不为 nil）
        // 3. 该元素有实际的动画帧
        // 才启动前景动画计时器。
        if currentConfig.foregroundElement.isAnimated,
           let speed = currentConfig.foregroundElement.animationSpeed,
           !currentConfig.foregroundElement.frames.isEmpty {
            
            // 重置前景动画的当前帧索引到第一帧
            foregroundFrameIndex = 0
            
            // 创建并启动前景动画计时器
            foregroundTimer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { [weak self] _ in
                guard let self = self else { return } // 弱引用 self，防止循环引用
                
                let framesCount = self.currentConfig.foregroundElement.frames.count
                guard framesCount > 0 else { return } // 确保有帧可播放
                
                // 更新前景动画的当前帧索引，实现循环播放
                self.foregroundFrameIndex = (self.foregroundFrameIndex + 1) % framesCount
                
                // 如果是“播放一次”的动画类型，并且已经到达最后一帧，则停止计时器
                if self.currentConfig.foregroundElement.animationLoopType == .once && self.foregroundFrameIndex == framesCount - 1 {
                    self.foregroundTimer?.invalidate()
                    self.foregroundTimer = nil
                }
            }
        }

        // --- 天气效果动画计时器设置 ---
        // 逻辑与前景动画类似，针对天气效果元素。
        if currentConfig.weatherElement.isAnimated,
           let speed = currentConfig.weatherElement.animationSpeed,
           !currentConfig.weatherElement.frames.isEmpty {
            
            // 重置天气动画的当前帧索引到第一帧
            weatherEffectFrameIndex = 0
            
            // 创建并启动天气动画计时器
            weatherEffectTimer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                let framesCount = self.currentConfig.weatherElement.frames.count
                guard framesCount > 0 else { return }
                
                // 更新天气动画的当前帧索引，实现循环播放
                self.weatherEffectFrameIndex = (self.weatherEffectFrameIndex + 1) % framesCount
                
                // 如果是“播放一次”的动画类型，并且已经到达最后一帧，则停止计时器
                if self.currentConfig.weatherElement.animationLoopType == .once && self.weatherEffectFrameIndex == framesCount - 1 {
                    self.weatherEffectTimer?.invalidate()
                    self.weatherEffectTimer = nil
                }
            }
        }
        
        // 远景元素目前设计为静态，所以不需要计时器。
        // 如果未来远景也支持动画，可以在这里添加新的计时器逻辑。
    }
    
    // 停止所有正在运行的动画计时器。
    func stopAllTimers() {
        foregroundTimer?.invalidate() // 使计时器失效
        foregroundTimer = nil          // 清除引用
        
        weatherEffectTimer?.invalidate()
        weatherEffectTimer = nil
    }
    
    // 当 RoomBackgroundManager 实例被销毁时，确保所有计时器也停止，防止内存泄漏。
    deinit {
        stopAllTimers()
    }
    
    // MARK: - 辅助获取当前显示帧的图片名称
    
    // 返回前景当前应该显示的图片名称。
    var currentForegroundImageName: String {
        // 如果前景元素不是动画类型，或者全局动画被禁用，则返回其第一帧（即静态图）。
        // 如果 frames 数组为空，返回空字符串。
        guard currentConfig.foregroundElement.isAnimated && isGlobalAnimationEnabled else {
            return currentConfig.foregroundElement.frames.first?.imageName ?? ""
        }
        // 如果是动画模式且全局动画启用，则返回当前动画帧索引对应的图片名称。
        return currentConfig.foregroundElement.frames[foregroundFrameIndex].imageName
    }

    // 返回远景当前应该显示的图片名称。
    // 远景元素目前设计为静态，所以直接返回第一帧图片名称。
    var currentDistantImageName: String {
        return currentConfig.distantElement.frames.first?.imageName ?? ""
    }
    
    // 返回天气效果当前应该显示的图片名称。
    // 逻辑与前景动画类似。
    var currentWeatherEffectImageName: String {
        guard currentConfig.weatherElement.isAnimated && isGlobalAnimationEnabled else {
            return currentConfig.weatherElement.frames.first?.imageName ?? ""
        }
        return currentConfig.weatherElement.frames[weatherEffectFrameIndex].imageName
    }
}
