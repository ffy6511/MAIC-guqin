//
//  RecentPracticeListViewModel.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import Foundation


class RecentPracticeListViewModel: ObservableObject {
    @Published var practices: [PracticeItem] = []

    init() {
        loadPractices()
    }

    private func loadPractices() {
        // 模拟数据加载
        practices = [
            PracticeItem(imageName: "recent_practice_image1", title: "《潇湘水云》", progress: "已练习8次"),
//            PracticeItem(imageName: "recent_practice_image2", title: "《广陵散》", progress: "已练习3次"),
//            PracticeItem(imageName: "recent_practice_image3", title: "《平沙落雁》", progress: "已练习5次")
        ]
    }

    func refreshPractices() {
        print("刷新最近练习列表")
        loadPractices()
    }
}
