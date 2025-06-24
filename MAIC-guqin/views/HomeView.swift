//
// HomeView.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/24.
//

import SwiftUI
import CoreLocation // 如果你的页面需要 CoreLocation，保持导入
import Foundation   // 如果你的页面需要 Date 等基础类型，保持导入


struct HomeView: View {
    // 视差滚动偏移量的状态变量，私有属性
    @State private var backgroundParallaxOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) { // ZStack 底部对齐，以便固定搜索栏

            // MARK: - 1. 背景层 (可滚动，实现视差)
            ScrollView {
                VStack {
                    // 顶部背景图片（高山流水）
                    Image("mountain_background") // 替换为你的图片名称
                        .resizable()
                        .scaledToFill() // 填充而不是适应
                        .frame(height: 300) // 初始高度
                        // .offset(y: backgroundParallaxOffset) // 视差偏移，暂时不启用
                        .clipped() // 裁剪超出 frame 的部分

                    // 古琴图片 (可点击跳转)
                    Image("guqin_background") // 替换为你的图片名称
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        // .offset(y: backgroundParallaxOffset) // 同样应用视差偏移，暂时不启用
                        .clipped() // 裁剪超出 frame 的部分
                        .onTapGesture {
                            // TODO: 跳转到古琴详情或练习 View
                            print("古琴图片被点击了！")
                        }

                    // 添加足够的 Spacer 或透明内容，让背景图能向上滚动露出下方内容
                    Color.clear.frame(height: 400) // 示意性空白区域，确保内容滚动时背景可见
                }
                .frame(maxWidth: .infinity)
                // .background(
                //     GeometryReader { proxy in
                //         Color.clear
                //             .preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
                //     }
                // )
            }
            // .coordinateSpace(name: "scroll")
            // .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            //     // 视差计算逻辑，暂时不启用
            //     let initialImageHeight: CGFloat = 300 + 200
            //     let parallaxFactor: CGFloat = 0.4
            //     let newOffset = (offset - initialImageHeight) * parallaxFactor
            //     self.backgroundParallaxOffset = min(0, newOffset)
            // }
            .edgesIgnoringSafeArea(.all) // 确保背景图充满屏幕


            // MARK: - 2. 内容层 (可滚动，覆盖在背景上)
            ScrollView {
                VStack(spacing: 20) {
                    // 顶部留白，以让背景图能显示出来
                    Spacer().frame(height: 450) // 留出背景图和顶部功能区的空间

                    // 功能区（定制古筝、快速弹奏、进入社区）
                    HStack(spacing: 20) {
                        FunctionalButton(title: "定制古筝", icon: "slider.horizontal.3")
                        FunctionalButton(title: "快速弹奏", icon: "guitars.fill")
                        FunctionalButton(title: "进入社区", icon: "person.3.fill")
                    }
                    .padding(.horizontal)

                    // 精彩推荐模块
                    RecommendationSection() // 直接使用已封装的 Section View

                    // 最近练习模块
                    RecentPracticeSection() // 直接使用已封装的 Section View

                    Spacer() // 确保内容可以向上滚动
                }
                .background(Color("BackgroundPrimary").opacity(0.95)) // 内容区域的背景色，使用 Assets 颜色
                // 移除了 .cornerRadius(20, corners: [.topLeft, .topRight]) 因为你还没有设计这个扩展
                // 如果需要圆角，请使用 Swift 原生的 .cornerRadius(20) 但它只支持所有角
                .cornerRadius(20) // 默认的全部圆角
            }
            .zIndex(1) // 确保内容层在背景层之上


            // MARK: - 3. 底部搜索栏 (固定)
            VStack {
                Spacer() // 将搜索栏推到底部
                SearchBarView() // 你的搜索栏组件
                    .padding(.bottom, 20) // 底部内边距，根据实际安全区域调整
            }
            .background(Color("BackgroundSecondary").opacity(0.95)) // 搜索栏背景，使用 Assets 颜色
            .shadow(radius: 5) // 阴影效果
            .zIndex(2) // 确保搜索栏在所有层之上
        }
        .edgesIgnoringSafeArea(.all) // 忽略安全区域，让整个 ZStack 充满屏幕
    }
}

#Preview {
    HomeView()
}
