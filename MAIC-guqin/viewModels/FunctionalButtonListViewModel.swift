//
// FunctionalButtonListViewModel.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/26.
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
        // 给定模拟的例子，为每个按钮定义不同的 action
        self.functionItems = [
            FunctionItem(title: "练习模式", icon: "music.note.list") { // **添加 action 闭包**
                print("点击了：练习模式")
                // TODO: 在这里添加导航到练习模式界面等逻辑
            },
            FunctionItem(title: "音阶模式", icon: "scale.3d") { // **添加 action 闭包**
                print("点击了：音阶模式")
                // TODO: 在这里添加导航到音阶模式界面等逻辑
            },
            FunctionItem(title: "课程学习", icon: "book.closed.fill") { // **添加 action 闭包**
                print("点击了：课程学习")
                // TODO: 在这里添加导航到课程学习界面等逻辑
            },
            FunctionItem(title: "自由演奏", icon: "guitars.fill") { // **添加 action 闭包**
                print("点击了：自由演奏")
            },
            FunctionItem(title: "曲库", icon: "square.grid.2x2.fill") { // **添加 action 闭包**
                print("点击了：曲库")
            },
            FunctionItem(title: "工具", icon: "wrench.adjustable.fill") { // **添加 action 闭包**
                print("点击了：工具")
            },
            FunctionItem(title: "设置", icon: "gearshape.fill") { // **添加 action 闭包**
                print("点击了：设置")
            }
        ]
    }
}
