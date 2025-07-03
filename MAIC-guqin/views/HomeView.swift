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
        FunctionItem(title: "定制古琴", icon: "slider.horizontal.3") { print("预览：定制古琴") },
        FunctionItem(title: "快速弹奏", icon: "waveform") { print("预览：快速弹奏") },
        FunctionItem(title: "进入社区", icon: "bubble.left.and.text.bubble.right") { print("预览：进入社区") }
    ]
    
    var body: some View {
        NavigationStack{
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
                                    .padding(.bottom, 10)
                            }
                            .background(Color.clear)
                            .zIndex(0)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Spacer()
                                    .frame(minHeight: geometry.size.height * 0.7)
                                
                                // 搜索栏
                                VStack {
                                    Spacer()
                                    SearchBarView()
                                        .padding()
                                }
                                .shadow(radius: 1)
                                .zIndex(3)
                                
                                
                                FunctionalButtonsSection(sectionTitle: nil, functionItems: previewItems)
                                    .frame(maxWidth: .infinity)
                                
                                RecommendationSection()
                                
                                RecentPracticeSection()
                                
                                Spacer()
                                    .frame(height: 20)
                            }
                            .frame(width: geometry.size.width)
                            .zIndex(1)
                        }
                    }
                }
                .zIndex(2)
            }
            .ignoresSafeArea(.all, edges: .top) // 整个视图忽略顶部安全区域
        }
        .navigationTitle("首页")
        .navigationBarTitleDisplayMode(.large)
    }
}


#Preview {
    HomeView()
}

