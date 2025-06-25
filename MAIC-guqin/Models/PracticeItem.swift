//
//  PracticeItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import Foundation

struct PracticeItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let progress: String
    var progressValue: Float? = 0.5  
}
