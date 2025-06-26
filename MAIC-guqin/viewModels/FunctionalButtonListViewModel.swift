//
//  FunctionalButtonListViewModel.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/26.
//

import Foundation
import Combine

class FunctionalButtonListViewModel: ObservableObject {
    @Published var functionItems: [FunctionItem] = []

    init() {
        // 模拟加载数据
        loadFunctionItems()
    }

    func loadFunctionItems() {
        // 给定模拟的例子
        self.functionItems = [
            FunctionItem(title: "练习模式", icon: "music.note.list"),
            FunctionItem(title: "音阶模式", icon: "scale.3d"),
            FunctionItem(title: "课程学习", icon: "book.closed.fill"),
            FunctionItem(title: "自由演奏", icon: "guitars.fill"),
            FunctionItem(title: "曲库", icon: "square.grid.2x2.fill"),
            FunctionItem(title: "工具", icon: "wrench.adjustable.fill"),
            FunctionItem(title: "设置", icon: "gearshape.fill")
        ]
    }
}
