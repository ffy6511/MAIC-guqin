//
//  FunctionalButtonsSection.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/26.
//

import SwiftUI

struct FunctionalButtonsSection: View {
    let sectionTitle: String?
    let functionItems: [FunctionItem]
    
    var dynamicColumns: [GridItem] {
        let maxColumns = 3 // 最大列数
        let currentColumnsCount = min(functionItems.count, maxColumns)
        guard currentColumnsCount > 0 else { return [] }
        return Array(repeating: GridItem(.flexible()), count: currentColumnsCount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let title = sectionTitle {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextPrimary"))
                    .padding(.leading, UIScreen.main.bounds.width * 0.02)
            }

            LazyVGrid(columns: dynamicColumns, spacing: 16) {
                ForEach(functionItems) { item in
                    // FunctionalButton 自身会负责填充其 GridItem 分配的空间
                    FunctionalButton(title: item.title, icon: item.icon, action: item.action)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct FunctionalButtonsSection_Previews: PreviewProvider {
    static var previews: some View {
        let previewItemsTwo = [
            FunctionItem(title: "实物扫描", icon: "camera.viewfinder") { print("预览：实物扫描") },
            FunctionItem(title: "辞典查询", icon: "magnifyingglass") { print("预览：辞典查询") }
        ]
        let previewItemsThree = [
            FunctionItem(title: "练习模式", icon: "music.note.list") { print("预览：练习模式") },
            FunctionItem(title: "音阶模式", icon: "scale.3d") { print("预览：音阶模式") },
            FunctionItem(title: "课程学习", icon: "book.closed.fill") { print("预览：课程学习") }
        ]

        Group {
            FunctionalButtonsSection(sectionTitle: "常用功能 (2个按钮)", functionItems: previewItemsTwo)
                .frame(height: 150) // 在预览中给它一个固定高度来测试
                .padding(.horizontal) // 模拟外部容器的 padding
                .previewLayout(.sizeThatFits)
                .previewDisplayName("功能按钮 Section (2 Items)")

            FunctionalButtonsSection(sectionTitle: "常用功能 (3个按钮)", functionItems: previewItemsThree)
                .frame(height: 150) // 在预览中给它一个固定高度来测试
                .padding(.horizontal) // 模拟外部容器的 padding
                .previewLayout(.sizeThatFits)
                .previewDisplayName("功能按钮 Section (3 Items)")
        }
    }
}
