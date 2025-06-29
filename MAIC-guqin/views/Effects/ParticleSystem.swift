//
//  ParticleSystem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation
import CoreGraphics
import SwiftUI

// 负责管理和更新所有粒子
class ParticleSystem {
    var particles = [Particle]() // 存储所有活跃的粒子
    var lastUpdate: TimeInterval? // 上次更新的时间戳
    var spawnRate: Double // 每秒生成多少粒子
    var renderRect: CGRect // 粒子渲染的区域
    var speedMultiplier: Double // 整体速度乘数
    var densityMultiplier: Double // 整体密度乘数

    init(spawnRate: Double = 50, renderRect: CGRect, speedMultiplier: Double = 1.0, densityMultiplier: Double = 1.0) {
        self.spawnRate = spawnRate * densityMultiplier
        self.renderRect = renderRect
        self.speedMultiplier = speedMultiplier
        self.densityMultiplier = densityMultiplier
    }

    // 更新粒子状态（位置，移除死亡粒子，生成新粒子）
    func update(at timestamp: TimeInterval) {
        // 首次更新时设置 lastUpdate
        guard let lastUpdate = lastUpdate else {
            self.lastUpdate = timestamp
            return
        }

        let deltaTime = timestamp - lastUpdate
        self.lastUpdate = timestamp

        // 移除已死亡或超出屏幕的粒子
        particles.removeAll { particle in
            particle.birthTime + particle.lifetime < timestamp || particle.position.y > renderRect.maxY + 50 // 略微超出底部才移除
        }

        // 更新现有粒子的位置和透明度
        for i in 0..<particles.count {
            particles[i].position.x += particles[i].velocity.width * CGFloat(deltaTime) * speedMultiplier
            particles[i].position.y += particles[i].velocity.height * CGFloat(deltaTime) * speedMultiplier

            // 根据生命周期调整透明度（可选的渐隐效果）
            let progress = (timestamp - particles[i].birthTime) / particles[i].lifetime
            particles[i].opacity = particles[i].opacity * (1.0 - progress) // 逐渐变淡
        }

        // 生成新粒子
        let particlesToSpawn = Int(spawnRate * deltaTime)
        for _ in 0..<particlesToSpawn {
            // 在渲染区域的顶部或略微上方生成新粒子
            let spawnY = renderRect.minY - CGFloat.random(in: 0...renderRect.height * 0.7) // 从屏幕上方一段距离开始生成
            let spawnRect = CGRect(x: renderRect.minX, y: spawnY, width: renderRect.width, height: renderRect.height / 1.5) // 在上半部分随机生成
            particles.append(Particle.createRandom(in: spawnRect, at: timestamp, speed: 100 * speedMultiplier, scale: 0.8)) // 基础速度
        }
    }
    
    // 重置粒子系统，清除所有粒子
    func reset() {
        particles.removeAll()
        lastUpdate = nil
    }
}
