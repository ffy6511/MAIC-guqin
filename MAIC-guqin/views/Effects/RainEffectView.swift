//
//  RainEffectView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import SwiftUI

struct RainEffectView: View {
    let isEnabled: Bool // 控制动画是否启用
    let animationScale: Double // 动画效果的缩放因子 (用于预览)

    @State private var particleSystem: ParticleSystem?
    @State private var canvasSize: CGSize = .zero

    var body: some View {
        // TimelineView 提供了持续的帧更新，适合动画
        TimelineView(.animation(minimumInterval: 1.0 / 60.0, paused: !isEnabled)) { timeline in
            Canvas { context, size in
                // 异步记录尺寸变化，避免在渲染期间修改状态
                if canvasSize != size {
                    DispatchQueue.main.async {
                        canvasSize = size
                    }
                }

                // 只进行绘制和更新，不修改状态结构
                guard isEnabled, let ps = particleSystem else {
                    return
                }

                // 在这里更新粒子系统（这不会修改 @State，只是更新粒子系统内部状态）
                ps.update(at: timeline.date.timeIntervalSinceReferenceDate)

                // 绘制每个粒子
                for particle in ps.particles {
                    context.stroke(
                        Path { path in
                            path.move(to: particle.position)
                            // 绘制一条短线作为雨滴
                            let endY = particle.position.y + CGFloat(particle.velocity.height * 0.08 * animationScale) // 雨滴长度
                            path.addLine(to: CGPoint(x: particle.position.x, y: endY))
                        },
                        with: .color(Color.blue.opacity(particle.opacity)), // 蓝色雨滴，透明度随生命周期变化
                        lineWidth: CGFloat(particle.scale * 3) // 雨滴宽度，随大小变化
                    )
                }
            }
        }
        .onAppear {
            // 视图出现时初始化粒子系统
            initializeParticleSystemIfNeeded()
        }
        .onChange(of: canvasSize) {
            // iOS 17+ 新语法：当画布尺寸改变时重新创建粒子系统
            if canvasSize != .zero {
                createParticleSystem(size: canvasSize)
            }
        }
        .onChange(of: isEnabled) {
            // iOS 17+ 新语法：当启用状态改变时处理粒子系统
            if !isEnabled {
                particleSystem?.reset()
            }
        }
        .onChange(of: animationScale) {
            // iOS 17+ 新语法：当动画缩放改变时重新创建粒子系统
            if canvasSize != .zero {
                createParticleSystem(size: canvasSize)
            }
        }
        .drawingGroup() // 提高 Canvas 性能
        .ignoresSafeArea() // 让雨滴覆盖整个屏幕
    }
    
    // MARK: - 私有方法
    
    /// 初始化粒子系统（如果需要）
    private func initializeParticleSystemIfNeeded() {
        if particleSystem == nil && canvasSize != .zero {
            createParticleSystem(size: canvasSize)
        }
    }
    
    /// 创建粒子系统
    private func createParticleSystem(size: CGSize) {
        particleSystem = ParticleSystem(
            spawnRate: 150 * animationScale, // 基础生成速率，乘以缩放因子
            renderRect: CGRect(origin: .zero, size: size),
            speedMultiplier: 1.0 * animationScale, // 速度乘以缩放因子
            densityMultiplier: 1.0 * animationScale // 密度乘以缩放因子
        )
    }
}

// MARK: - RainEffectView 的预览
struct RainEffectView_Previews: PreviewProvider {
    static var previews: some View {
        // 预览启用状态下的雨滴
        RainEffectView(isEnabled: true, animationScale: 1.0)
            .previewDisplayName("雨滴效果")
            .background(Color.black) // 在深色背景下更容易看到雨滴

        // 预览禁用状态下的雨滴 (应该不显示任何雨滴)
        RainEffectView(isEnabled: false, animationScale: 1.0)
            .previewDisplayName("雨滴效果 (禁用)")
            .background(Color.black)
        
        // 预览不同缩放比例的雨滴
        RainEffectView(isEnabled: true, animationScale: 0.5)
            .previewDisplayName("雨滴效果 (缩放 0.5)")
            .background(Color.black)
    }
}
