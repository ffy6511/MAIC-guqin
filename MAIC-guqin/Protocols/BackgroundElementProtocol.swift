//
//  BackgroundElementProtocol.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

protocol BackgroundElement: Identifiable, Hashable, Codable { // 确保可识别、可哈希、可编码
    var id: String { get } // 为了更稳定的标识符，可以使用 name 作为 id
    var name: String { get }
    var description: String { get }
    var isAnimated: Bool { get } // 是否是动画
    var frames: [BackgroundAnimationFrame] { get } // 图片数组，动画时多帧，静态时一帧
    
    // 动画特有属性（可选，如果某个元素不需要动画，这些可以为nil）
    var animationSpeed: Double? { get } // 动画速度 (每秒帧数或帧间隔时间)
    var animationLoopType: BackgroundAnimationLoopType? { get } // 动画循环类型
}

