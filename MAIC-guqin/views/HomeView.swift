//
// HomeView.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/24.
//

import SwiftUI
import CoreLocation
import Foundation


struct HomeView: View {
    // 视差滚动偏移量的状态变量，私有属性
    @State private var backgroundParallaxOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            
            LinearGradient(
                            gradient: Gradient(colors: [Color.brandPrimary, Color.white]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
            
            
            
                VStack(spacing: -130) {
                    // 顶部大图
                    ZStack {
                        Image("Ellipse")
                            .resizable()
                            .frame(height:400)
//                            .scaledToFit()
                            .opacity(0.7)
                            
                        
                        
                        Image("mountain_background")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350)
                            .clipped()
                    }
                    
                    
                    // 下面的两张图片重叠在一起
                    ZStack {
                        Image("guqin")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .opacity(0.9)
                        
                        Image("words")
                            .resizable()
                            .scaledToFit()
//                            .frame(width:200)
                            .opacity(0.28)
                    }
                    .frame(height: 350)
                    
                    Spacer()
                }
                
                
//            TODO: 构造合适的scroll视图存放内容卡片
            VStack{
                RecommendationSection()
                
                RecentPracticeSection()
            }
            
        
            VStack {
                Spacer() // 将搜索栏推到底部
                SearchBarView() // 你的搜索栏组件
                    .padding(20) // 底部内边距，根据实际安全区域调整
            }
            .shadow(radius: 5) // 阴影效果
            .zIndex(2) // 确保搜索栏在所有层之上
        }
        
        
    }
}

#Preview {
    HomeView()
}
