//
// ScoreSection.swift 
// MAIC-guqin
//
// Created by Zhuo on 2025/6/26.
//

import SwiftUI

struct ScoreSection: View {
    let sectionTitle: String? // Section 标题，例如 "动态曲谱"
    let showMoreButton: Bool // 是否显示右侧的“更多”按钮
    
    @EnvironmentObject var scoreDataManager: ScoreDataManager
    
    @ObservedObject var viewModel: ScoreSectionViewModel // 接收 ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) { // 整体垂直布局
            // Section 标题和“更多”按钮
            HStack {
                if let title = sectionTitle {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextPrimary"))
                }
                Spacer()
                if showMoreButton {
                    Button(action: {
                        print("更多 \(sectionTitle ?? "内容")")
                    }) {
                        Image(systemName: "ellipsis") // 三个点图标
                            .font(.title2)
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
            }
            .padding(.horizontal) // 标题和更多按钮的水平内边距

            // 曲谱列表，垂直滚动
            ScrollView(.vertical, showsIndicators: false) { // 允许垂直滚动，不显示滚动条
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.scoreItems) { item in
                        // 将 ScoreItemCard 包装在 NavigationLink 中
                        NavigationLink(destination: ScoreDetailView(scoreItem: item)) {
                            ScoreItemCard(item: item)
                        }
                        .buttonStyle(PlainButtonStyle()) // 移除 NavigationLink 默认的蓝色文本样式
                        .buttonStyle(CardPressEffectStyle()) // 使用自定义样式
                    }
                }
                .padding(.horizontal) // 为所有卡片及其容器添加水平内边距
            }
//            .frame(height: 120)
        }
        .padding(.vertical, 5) // 整个 Section 的垂直内边距
    }
}

struct ScoreSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ScoreSectionViewModel()
        // 在预览中也用 NavigationStack 包裹
        NavigationStack {
            VStack {
                ScoreSection(sectionTitle: "动态曲谱", showMoreButton: true, viewModel: viewModel)
                    .frame(width: 380)
                    .background(Color.white)
                    .environmentObject(ScoreDataManager())
            }
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("动态曲谱 Section (滚动准备就绪)")
    }
}
