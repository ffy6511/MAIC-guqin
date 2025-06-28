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
    @EnvironmentObject var appSettings: AppSettings

    @State private var backgroundParallaxOffset: CGFloat = 0

    let previewItems = [
        FunctionItem(title: "练习模式", icon: "music.note.list") { print("预览：练习模式") },
        FunctionItem(title: "音阶模式", icon: "scale.3d") { print("预览：音阶模式") },
        FunctionItem(title: "课程学习", icon: "book.closed.fill") { print("预览：课程学习") }
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // 简化的渐变背景 - 直接覆盖整个屏幕，用透明色控制
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.clear,           // 顶部透明
                    Color.brandPrimary.opacity(0.8),           // 中部透明
                    Color.brandPrimary,    // 开始渐变
                    Color.white          // 底部白色
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .zIndex(0)
            
            // 图片内容
            VStack(spacing: -180) {
                // 顶部大图
                ZStack {
                    Image("Ellipse")
                        .resizable()
                        .frame(height: 350)
                        .scaledToFit()
                        .ignoresSafeArea(.all, edges: .top) // 确保延伸到顶部
                        
                    Image("mountain_background")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .clipped()
                        .offset(y:-50)
                }
                
                // 古琴图片
                ZStack {
                    Image("guqin")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .opacity(0.9)
                    
                    Image("words")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.28)
                }
                .frame(height: 350)
                
                Spacer() // 推到顶部
            }
            .zIndex(1)
            
            // ScrollView内容
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        VStack {
                            Spacer()
                                .frame(minHeight: geometry.size.height * 0.65)

                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial.opacity(0.5))
                                .padding(.bottom, 20)

                            Spacer(minLength: 80)
                        }
                        .background(Color.clear)
                        .zIndex(0)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Spacer()
                                .frame(minHeight: geometry.size.height * 0.7)
                            
                            FunctionalButtonsSection(sectionTitle: nil, functionItems: previewItems)
                                .frame(maxWidth: .infinity)
                            
                            RecommendationSection()
                            
                            RecentPracticeSection()
                            
                            Spacer()
                                .frame(height: 80)
                        }
                        .frame(width: geometry.size.width)
                        .padding(.bottom, 20)
                        .zIndex(1)
                    }
                }
            }
            .zIndex(2)

            // 搜索栏
            VStack {
                Spacer()
                SearchBarView()
                    .padding(20)
            }
            .shadow(radius: 4)
            .zIndex(3)
        }
        .ignoresSafeArea(.all, edges: .top) // 整个视图忽略顶部安全区域
    }
}


#Preview {
    HomeView()
}

