//
//  RecommendationItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import Foundation

struct RecommendationItem:Identifiable{
    let id = UUID()
    let imageName:String
    let title:String
    let subtitle: String
    let date: String
    let plays: String
}
