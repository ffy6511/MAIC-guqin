//
//  RecommendationListViewModel.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import Foundation


class RecommendationListViewModel: ObservableObject {
    @Published var recommendations: [RecommendationItem] = []

    init() {
        loadRecommendations()
    }

    private func loadRecommendations() {
        // 模拟数据加载
        recommendations = [
            RecommendationItem(imageName: "recommendation_image1", title: "苏思思-《潇湘水云》", subtitle: "中央民族乐团古筝之夜", date: "2024.10.27 深圳", plays: "已作词作曲8次"),
            RecommendationItem(imageName: "recommendation_image2", title: "赵家珍-《春风》", subtitle: "中央民族乐团古筝之夜", date: "2024.10.27 深圳", plays: "已作词作曲8次"),
            RecommendationItem(imageName: "recommendation_image3", title: "古琴大师演奏精选", subtitle: "经典古琴曲集", date: "2024.11.01 全国", plays: "已作词作曲12次")
        ]
    }

    func refreshRecommendations() {
        // 重新加载数据的逻辑
        print("刷新推荐列表")
        loadRecommendations()
    }
}
