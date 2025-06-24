//
//  RecommendationSection.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI


struct RecommendationSection: View {
    let title: String = "精彩推荐" // 可以在这里直接定义标题，或者从外部传入
    @StateObject private var viewModel = RecommendationListViewModel() // 拥有自己的 ViewModel 实例

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("TextPrimary")) // 使用 Assets 颜色
                Spacer()
                Button {
                    viewModel.refreshRecommendations()
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color("TextSecondary")) // 使用 Assets 颜色
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.recommendations) { item in
                        RecommendationCard(item: item) // 将整个 Model item 传递给 Card
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}
