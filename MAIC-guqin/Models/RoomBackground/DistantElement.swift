//
//  DistantElement.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

// 远处环境元素：实现 BackgroundElement 协议
struct DistantElement: BackgroundElement {
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

    // 预设的远处环境元素列表
    static let allElements: [DistantElement] = [

        DistantElement(
            id: "mountain_distant",
            name: "静谧山水",
            description: "远处巍峨的山峦。",
            isAnimated: false, // 静态
            frames: [
                BackgroundAnimationFrame(imageName: "distant_mountain_static")
            ],
            animationSpeed: nil,
            animationLoopType: nil
        ),
        DistantElement(
            id: "no_distant",
            name: "无远景",
            description: "不显示远处环境。",
            isAnimated: false,
            frames: [],
            animationSpeed: nil,
            animationLoopType: nil
        ),
        DistantElement(
            id: "clouds_distant",
            name: "云海缭绕",
            description: "远方漂浮的云海。",
            isAnimated: false, // 静态
            frames: [
                BackgroundAnimationFrame(imageName: "distant_clouds_static")
            ],
            animationSpeed: nil,
            animationLoopType: nil
        )
    ]
    
    // 默认的远处环境元素
    static let defaultElement: DistantElement = .allElements.first!
}
