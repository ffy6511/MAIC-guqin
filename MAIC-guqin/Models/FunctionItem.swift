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
}
