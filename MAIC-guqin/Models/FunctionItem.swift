//
//  FunctionItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/26.
//

import Foundation

struct FunctionItem: Identifiable {
    let id = UUID() // 用于 ForEach 唯一标识
    let title: String
    let icon: String
    let action: () -> Void
    
//    默认的构造函数，如果没有提供指定的action，自动设置为空
    init(title:String, icon: String, action: @escaping()->Void = {}){
        self.title = title
        self.icon = icon
        self.action = action
    }
}


