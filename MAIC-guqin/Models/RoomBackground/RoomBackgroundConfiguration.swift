//
//  RoomBackgroundConfiguration.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

// RoomBackgroundConfiguration：定义当前房间背景的完整组合配置
struct RoomBackgroundConfiguration: Codable, Hashable {
    var foregroundElement: ForegroundElement
    var distantElement: DistantElement
    var weatherElement: WeatherElement

    // 默认的背景配置，用于应用程序启动时或重置时
    // 它从每个分类的 defaultElement 中获取默认值
    static let defaultConfig = RoomBackgroundConfiguration(
        foregroundElement: .defaultElement, // 例如：无前景
        distantElement: .defaultElement,     // 例如：无远景
        weatherElement: .defaultElement      // 例如：无天气
    )
}
