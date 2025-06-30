//
//  RoomNavBarItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/30.
//


import SwiftUI

struct RoomNavBarItem: View {
    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .medium)) // 调整字体大小
            
            Text(title)
                .font(.system(size: 14, weight: .medium)) // 调整字体大小
        }
        .frame(width: 100, height: 80) // 保持尺寸，由它内部的内容决定
    }
}

// 预览保持不变
struct RoomNavBarItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RoomNavBarItem(
                icon: "cloud.fill",
                title: "环境系统"
            )
            
            RoomNavBarItem(
                icon: "mic.fill",
                title: "情境录制"
            )
            
            RoomNavBarItem(
                icon: "person.3.fill",
                title: "多人琴室"
            )
        }
        .padding()
        // RoomNavBarItem_Previews 不再需要 AppSettings
        .previewLayout(.sizeThatFits)
    }
}
