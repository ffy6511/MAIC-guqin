//
//  SnowEffectView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/29.
//

import SwiftUI

struct SnowEffectView: View {
    let isEnabled: Bool // 控制动画是否启用
    let animationScale: Double // 动画效果的缩放因子

    @State private var particleSystem: SnowParticleSystem?
    @State private var canvasSize: CGSize = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 60.0, paused: !isEnabled)) { timeline in
            Canvas { context, size in
                // 异步记录尺寸变化
                if canvasSize != size {
                    DispatchQueue.main.async {
                        canvasSize = size
                    }
                }

                guard isEnabled, let ps = particleSystem else {
                    return
                }

                // 更新粒子系统
                ps.update(at: timeline.date.timeIntervalSinceReferenceDate)

                // 绘制每个雪花
                for particle in ps.particles {
                    drawSnowflake(context: context, particle: particle)
                }
            }
        }
        .onAppear {
            initializeParticleSystemIfNeeded()
        }
        .onChange(of: canvasSize) {
            if canvasSize != .zero {
                createParticleSystem(size: canvasSize)
            }
        }
        .onChange(of: isEnabled) {
            if !isEnabled {
                particleSystem?.reset()
            }
        }
        .onChange(of: animationScale) {
            if canvasSize != .zero {
                createParticleSystem(size: canvasSize)
            }
        }
        .drawingGroup()
        .ignoresSafeArea()
    }
    
    // MARK: - 雪花绘制
    
    private func drawSnowflake(context: GraphicsContext, particle: SnowParticle) {
        let center = particle.position
        
//        基础大小
        let size = CGFloat(particle.scale * 4 * animationScale)
        let opacity = particle.opacity
        
        // 绘制六角雪花
        context.stroke(
            Path { path in
                // 六个方向的线条
                for i in 0..<6 {
                    let angle = Double(i) * .pi / 3 + particle.rotation
                    let startX = center.x + cos(angle) * size * 0.3
                    let startY = center.y + sin(angle) * size * 0.3
                    let endX = center.x + cos(angle) * size
                    let endY = center.y + sin(angle) * size
                    
                    path.move(to: CGPoint(x: startX, y: startY))
                    path.addLine(to: CGPoint(x: endX, y: endY))
                    
                    // 添加分支
                    let branchAngle1 = angle + .pi / 6
                    let branchAngle2 = angle - .pi / 6
                    let branchLength = size * 0.3
                    
                    let midX = center.x + cos(angle) * size * 0.7
                    let midY = center.y + sin(angle) * size * 0.7
                    
                    path.move(to: CGPoint(x: midX, y: midY))
                    path.addLine(to: CGPoint(
                        x: midX + cos(branchAngle1) * branchLength,
                        y: midY + sin(branchAngle1) * branchLength
                    ))
                    
                    path.move(to: CGPoint(x: midX, y: midY))
                    path.addLine(to: CGPoint(
                        x: midX + cos(branchAngle2) * branchLength,
                        y: midY + sin(branchAngle2) * branchLength
                    ))
                }
            },
            with: .color(Color.white.opacity(opacity)),
            lineWidth: 1.5
        )
    }
    
    // MARK: - 私有方法
    
    private func initializeParticleSystemIfNeeded() {
        if particleSystem == nil && canvasSize != .zero {
            createParticleSystem(size: canvasSize)
        }
    }
    
    private func createParticleSystem(size: CGSize) {
        particleSystem = SnowParticleSystem(
            spawnRate: 60 * animationScale, // 雪花生成较慢
            renderRect: CGRect(origin: .zero, size: size),
            speedMultiplier: 0.6 * animationScale, // 雪花下落较慢
            densityMultiplier: 1.0 * animationScale
        )
    }
}


// MARK: - Previews
struct SnowEffectView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 预览1：标准雪花效果
            SnowEffectView(isEnabled: true, animationScale: 1.0)
                .previewDisplayName("标准雪花效果")
                .background(
                    LinearGradient(
                        colors: [Color.black, Color.blue.opacity(0.3)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .previewLayout(.sizeThatFits)
                .frame(width: 300, height: 500)

        }
    }
}


