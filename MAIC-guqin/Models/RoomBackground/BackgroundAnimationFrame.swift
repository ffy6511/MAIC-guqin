//
//  BackgroundAnimationFrame.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import Foundation

struct BackgroundAnimationFrame: Identifiable, Hashable, Codable {
    var id = UUID() // 用于 SwiftUI 的 ForEach
    let imageName: String // Assets.xcassets 中的图片名称
}
