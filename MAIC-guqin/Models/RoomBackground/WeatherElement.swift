//
//  WeatherElement.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

enum WeatherEffectType: String, Codable, CaseIterable, Identifiable {
    case none = "无"
    case rain = "细雨"
    case snow = "飞雪"

    var id: String { self.rawValue }
}

// 天气效果元素：实现 BackgroundElement 协议
struct WeatherElement: BackgroundElement {
    let id: String
    let name: String
    let description: String
    let isAnimated: Bool
    let frames: [BackgroundAnimationFrame]
    let animationSpeed: Double?
    let animationLoopType: BackgroundAnimationLoopType?
    
    let weatherEffectType: WeatherEffectType?
    

    // 实现 BackgroundElement 协议的初始化方法
    init(id: String, name: String, description: String, isAnimated: Bool, frames: [BackgroundAnimationFrame], animationSpeed: Double?, animationLoopType: BackgroundAnimationLoopType?,weatherEffectType: WeatherEffectType?) {
        self.id = id
        self.name = name
        self.description = description
        self.isAnimated = isAnimated
        self.frames = frames
        self.animationSpeed = animationSpeed
        self.animationLoopType = animationLoopType
        self.weatherEffectType = weatherEffectType
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
            animationLoopType: nil,
            weatherEffectType: WeatherEffectType.none
        ),
        WeatherElement(
            id: "rain_weather",
            name: "细雨濛濛",
            description: "轻柔雨丝飘落效果。",
            isAnimated: true, // 动画
            frames:[], // 使用粒子效果
            animationSpeed: 0.1, // 每帧间隔0.1秒
            animationLoopType: .loop, // 循环播放
            weatherEffectType: .rain
        ),
        WeatherElement(
            id: "snow_weather",
            name: "漫天飞雪",
            description: "雪花片片飘落效果。",
            isAnimated: true, // 动画
            frames: [],
            animationSpeed: 0.2,
            animationLoopType: .loop,
            weatherEffectType: .snow
        )
    ]
    
    // 默认的天气效果元素
    static let defaultElement: WeatherElement = .allElements.first!
}
