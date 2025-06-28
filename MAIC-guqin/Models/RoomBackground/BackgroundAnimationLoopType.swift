//
//  BackgroundAnimationLoopType.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

// 定义动画的播放模式
enum BackgroundAnimationLoopType: String, Codable, CaseIterable, Identifiable {
    // 循环播放，动画结束后从头开始
    case loop       = "循环"
    // 只播放一次，动画结束后停留在最后一帧
    case once       = "播放一次"
    
    // 用于 Identifiable 协议，使用原始值作为唯一标识
    var id: String { self.rawValue }
}
