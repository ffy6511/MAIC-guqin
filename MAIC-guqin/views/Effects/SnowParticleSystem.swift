//
//  SnowParticleSystem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/29.
//

import SwiftUI

class SnowParticle {
    var position: CGPoint
    var velocity: CGSize
    var scale: Double
    var opacity: Double
    var rotation: Double
    var rotationSpeed: Double
    var lifespan: Double
    var age: Double
    
    init(position: CGPoint, velocity: CGSize, scale: Double, rotation: Double, rotationSpeed: Double, lifespan: Double) {
        self.position = position
        self.velocity = velocity
        self.scale = scale
        self.opacity = 1.0
        self.rotation = rotation
        self.rotationSpeed = rotationSpeed
        self.lifespan = lifespan
        self.age = 0
    }
    
    func update(deltaTime: Double) {
        // 更新位置
        position.x += velocity.width * deltaTime
        position.y += velocity.height * deltaTime
        
        // 更新旋转
        rotation += rotationSpeed * deltaTime
        
        // 添加轻微的左右摆动
        let swayAmount = sin(age * 2) * 10
        position.x += swayAmount * deltaTime
        
        // 更新年龄和透明度
        age += deltaTime
        opacity = max(0, 1 - (age / lifespan))
    }
    
    var isAlive: Bool {
        age < lifespan && opacity > 0
    }
    
    static func createRandom(in rect: CGRect, at timestamp: Double, speed: Double, scale: Double) -> SnowParticle {
        let position = CGPoint(
            x: CGFloat.random(in: rect.minX...rect.maxX),
            y: CGFloat.random(in: rect.minY...rect.maxY)
        )
        
        let velocity = CGSize(
            width: CGFloat.random(in: -20...20), // 轻微的水平漂移
            height: CGFloat.random(in: 30...80) * speed // 垂直下落速度
        )
        
        let particleScale = Double.random(in: 0.7...1.2) * scale
        let rotation = Double.random(in: 0...(.pi * 2))
        let rotationSpeed = Double.random(in: -1...1)
        let lifespan = Double.random(in: 10...20) // 雪花存活时间较长
        
        return SnowParticle(
            position: position,
            velocity: velocity,
            scale: particleScale,
            rotation: rotation,
            rotationSpeed: rotationSpeed,
            lifespan: lifespan
        )
    }
}

class SnowParticleSystem {
    var particles: [SnowParticle] = []
    let spawnRate: Double
    let renderRect: CGRect
    let speedMultiplier: Double
    let densityMultiplier: Double
    
    private var lastUpdateTime: Double?
    
    init(spawnRate: Double, renderRect: CGRect, speedMultiplier: Double, densityMultiplier: Double) {
        self.spawnRate = spawnRate
        self.renderRect = renderRect
        self.speedMultiplier = speedMultiplier
        self.densityMultiplier = densityMultiplier
    }
    
    func update(at timestamp: Double) {
        let deltaTime = lastUpdateTime.map { timestamp - $0 } ?? 0
        lastUpdateTime = timestamp
        
        guard deltaTime > 0 else { return }
        
        // 更新现有粒子
        for particle in particles {
            particle.update(deltaTime: deltaTime)
        }
        
        // 移除死亡或超出边界的粒子
        particles.removeAll { particle in
            !particle.isAlive || particle.position.y > renderRect.maxY + 100
        }
        
        // 生成新雪花
        let particlesToSpawn = Int(spawnRate * deltaTime * densityMultiplier)
        for _ in 0..<particlesToSpawn {
            let spawnY = renderRect.minY - CGFloat.random(in: 0...renderRect.height * 0.5)
            let spawnRect = CGRect(x: renderRect.minX, y: spawnY, width: renderRect.width, height: renderRect.height / 3)
            particles.append(SnowParticle.createRandom(in: spawnRect, at: timestamp, speed: speedMultiplier, scale: 1.0))
        }
    }
    
    func reset() {
        particles.removeAll()
        lastUpdateTime = nil
    }
}
