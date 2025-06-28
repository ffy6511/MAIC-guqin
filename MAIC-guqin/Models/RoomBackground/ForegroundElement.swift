//
//  ForegroundElement.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

// 前景元素：实现 BackgroundElement 协议
struct ForegroundElement: BackgroundElement {
    let id: String // 使用字符串ID，例如 "no_foreground", "bamboo_foreground"
    let name: String
    let description: String
    let isAnimated: Bool
    let frames: [BackgroundAnimationFrame]
    let animationSpeed: Double?
    let animationLoopType: BackgroundAnimationLoopType?

    // 实现 BackgroundElement 协议的初始化方法
    // 确保所有属性都通过 init 方法赋值
    init(id: String, name: String, description: String, isAnimated: Bool, frames: [BackgroundAnimationFrame], animationSpeed: Double?, animationLoopType: BackgroundAnimationLoopType?) {
        self.id = id
        self.name = name
        self.description = description
        self.isAnimated = isAnimated
        self.frames = frames
        self.animationSpeed = animationSpeed
        self.animationLoopType = animationLoopType
    }
    
    // 预设的前景元素列表
    static let allElements: [ForegroundElement] = [
        ForegroundElement(
            id: "no_foreground",
            name: "无前景",
            description: "不显示任何前景装饰。",
            isAnimated: false, // 静态
            frames: [], // 没有图片，或者可以放一个透明的占位图
            animationSpeed: nil,
            animationLoopType: nil
        ),
        ForegroundElement(
            id: "bamboo_foreground",
            name: "竹林微风",
            description: "前景竹子轻柔摆动。",
            isAnimated: true, // 动画
            frames: [
                BackgroundAnimationFrame(imageName: "foreground_bamboo_01"),
                BackgroundAnimationFrame(imageName: "foreground_bamboo_02"),
                BackgroundAnimationFrame(imageName: "foreground_bamboo_03")
                // 确保在 Assets.xcassets 中有这些图片
            ],
            animationSpeed: 0.15, // 每帧间隔0.15秒
            animationLoopType: .loop // 循环播放
        ),
        ForegroundElement(
            id: "stone_foreground",
            name: "前景山石",
            description: "前景处的静止山石点缀。",
            isAnimated: false, // 静态
            frames: [
                BackgroundAnimationFrame(imageName: "foreground_stone_static")
                // 确保在 Assets.xcassets 中有这张图片
            ],
            animationSpeed: nil,
            animationLoopType: nil
        )
        // 您可以根据需要添加更多 ForegroundElement 实例
        // 例如：ForegroundElement(id: "lotus_pond", name: "荷塘月色", ...)
    ]
    
    // 默认的前景元素（通常是列表中的第一个或一个特定的“无”选项）
    static let defaultElement: ForegroundElement = .allElements.first!
}
