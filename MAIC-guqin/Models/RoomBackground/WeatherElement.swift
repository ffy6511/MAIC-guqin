//
//  WeatherElement.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

// 天气效果元素：实现 BackgroundElement 协议
struct WeatherElement: BackgroundElement {
    let id: String
    let name: String
    let description: String
    let isAnimated: Bool
    let frames: [BackgroundAnimationFrame]
    let animationSpeed: Double?
    let animationLoopType: BackgroundAnimationLoopType?

    // 实现 BackgroundElement 协议的初始化方法
    init(id: String, name: String, description: String, isAnimated: Bool, frames: [BackgroundAnimationFrame], animationSpeed: Double?, animationLoopType: BackgroundAnimationLoopType?) {
        self.id = id
        self.name = name
        self.description = description
        self.isAnimated = isAnimated
        self.frames = frames
        self.animationSpeed = animationSpeed
        self.animationLoopType = animationLoopType
    }
    
    // 预设的天气效果元素列表
    static let allElements: [WeatherElement] = [
        WeatherElement(
            id: "no_weather",
            name: "无天气",
            description: "不显示任何天气效果。",
            isAnimated: false, // 静态
            frames: [],
            animationSpeed: nil,
            animationLoopType: nil
        ),
        WeatherElement(
            id: "rain_weather",
            name: "细雨濛濛",
            description: "轻柔雨丝飘落效果。",
            isAnimated: true, // 动画
            frames: [
                BackgroundAnimationFrame(imageName: "weather_rain_01"),
                BackgroundAnimationFrame(imageName: "weather_rain_02"),
                BackgroundAnimationFrame(imageName: "weather_rain_03")
                // 确保在 Assets.xcassets 中有这些图片
            ],
            animationSpeed: 0.1, // 每帧间隔0.1秒
            animationLoopType: .loop // 循环播放
        ),
        WeatherElement(
            id: "snow_weather",
            name: "漫天飞雪",
            description: "雪花片片飘落效果。",
            isAnimated: true, // 动画
            frames: [
                BackgroundAnimationFrame(imageName: "weather_snow_01"),
                BackgroundAnimationFrame(imageName: "weather_snow_02"),
                BackgroundAnimationFrame(imageName: "weather_snow_03")
                // 确保在 Assets.xcassets 中有这些图片
            ],
            animationSpeed: 0.2,
            animationLoopType: .loop
        )
        // 您可以根据需要添加更多 WeatherElement 实例
        // 例如：WeatherElement(id: "fog_effect", name: "迷雾弥漫", ...)
    ]
    
    // 默认的天气效果元素
    static let defaultElement: WeatherElement = .allElements.first!
}
