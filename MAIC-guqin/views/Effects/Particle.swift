//
//  Particle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation
import CoreGraphics // For CGPoint, CGSize
import SwiftUICore

// 定义单个雨滴粒子
struct Particle {
    var position: CGPoint // 当前位置
    var velocity: CGSize  // 速度向量 (dx, dy)
    var lifetime: TimeInterval // 生命周期
    var birthTime: TimeInterval // 粒子生成的时间戳
    var opacity: Double // 透明度
    var scale: Double // 大小
    var rotation: Angle // 旋转角度

    // 便于生成随机粒子
    static func createRandom(in rect: CGRect, at timestamp: TimeInterval, speed: Double, scale: Double) -> Particle {
        let x = CGFloat.random(in: rect.minX...rect.maxX)
        let y = CGFloat.random(in: rect.minY...rect.maxY) // 从顶部或略高于顶部生成
        
        // 雨滴通常向下运动
        let dx = CGFloat.random(in: -5...5) // 模拟风的微小水平偏移
        let dy = CGFloat.random(in: speed * 0.8...speed * 1.2) // 向下速度

        return Particle(
            position: CGPoint(x: x, y: y),
            velocity: CGSize(width: dx, height: dy),
            lifetime: TimeInterval.random(in: 2...4.0), // 可见的时间
            birthTime: timestamp,
            opacity: Double.random(in: 0.6...1.0),
            scale: Double.random(in: scale * 0.8...scale * 1.2),
            rotation: .zero
        )
    }
}
