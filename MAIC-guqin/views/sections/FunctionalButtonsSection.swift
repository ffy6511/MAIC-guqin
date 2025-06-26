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

    let columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
           VStack(alignment: .leading, spacing: 15) { // 整体垂直堆叠：标题 + 滚动区域
               // Section 标题
               if let title = sectionTitle{
                   Text(title)
                       .font(.title2)
                       .fontWeight(.bold) // 添加fontWeight，与图片样式更接近
                       .foregroundColor(Color("TextPrimary"))
               }

               // 水平滚动视图，包含所有 FunctionalButton
               LazyVGrid(columns: columns, spacing: 16) {
                   ForEach(functionItems) { item in
                       FunctionalButton(title: item.title, icon: item.icon, action: item.action)
                   }
               }
               .padding(.horizontal) // LazyVGrid 内部的水平内边距
           }
           .padding(.vertical) // 整个 VStack 的垂直内边距

           // 将宽度的逻辑和 GeometryReader 应用到最外层，
           // 这样 VStack 自身会先计算出内容高度，然后 GeometryReader 适应它。
           .background(
               GeometryReader { geometry in
                   // 在这里可以获取到父容器的宽度，用于计算 80% 宽度
                   Color.clear // GeometryReader 内部需要一个视图
                       .onAppear {
                           // 如果需要基于 GeometryReader 的尺寸进行其他操作，可以在这里做
                           // 但对于 80% 宽度，直接用 padding 更直观
                       }
               }
           )
           // 这个 .frame 设置的是整个 FunctionalButtonsSection 的宽度
           .frame(maxWidth: .infinity) // 允许它尽可能宽
           .padding(.horizontal, UIScreen.main.bounds.width * 0.02)
       }
   }

// 预览
struct FunctionalButtonsSection_Previews: PreviewProvider {
    static var previews: some View {
        let previewItems = [
                    FunctionItem(title: "练习模式", icon: "music.note.list") { print("预览：练习模式") },
                    FunctionItem(title: "音阶模式", icon: "scale.3d") { print("预览：音阶模式") },
                    FunctionItem(title: "课程学习", icon: "book.closed.fill") { print("预览：课程学习") }
                ]

        FunctionalButtonsSection(sectionTitle: "常用功能", functionItems: previewItems)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("功能按钮 Section")
    }
}
