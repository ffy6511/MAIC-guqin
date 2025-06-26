//
//  FunctionalButtonsSection.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/26.
//

import SwiftUI

struct FunctionalButtonsSection: View {
    let sectionTitle: String?
    @StateObject private var viewModel = FunctionalButtonListViewModel() // 拥有自己的 ViewModel 实例

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
                    .foregroundColor(Color("TextPrimary"))
                    .padding(.horizontal) // 给标题添加左右内边距
            }


            // 水平滚动视图，包含所有 FunctionalButton
            LazyVGrid(columns: columns, spacing: 16) {
                // 只取前 3 个按钮
                ForEach(viewModel.functionItems.prefix(3)) { item in // <--- 关键修改：.prefix(3)
                    FunctionalButton(title: item.title, icon: item.icon)
                        // 可以在这里添加 .onTapGesture { /* 处理点击 */ }
                }
            }
            .padding(.horizontal) // 给整个 LazyVGrid 添加左右内边距
        }
        .padding(.vertical)
    }
}

// 预览
struct FunctionalButtonsSection_Previews: PreviewProvider {
    static var previews: some View {
        FunctionalButtonsSection(sectionTitle: "常用功能")
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("功能按钮 Section")
    }
}
