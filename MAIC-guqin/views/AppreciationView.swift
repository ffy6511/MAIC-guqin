//
//  AppreciationView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI

enum MasterPerformanceTab: String, CaseIterable, Identifiable{
    case classicVideos = "经典影像"
    case animatedShadows = "动画剪影"
    case communityShare = "社区分享"
    
    var id: String { self.rawValue }
}

struct AppreciationView: View {
    //    当前功能按钮的items
    let previewItems = [
        // "实物扫描" 按钮
        FunctionItem(title: "实物扫描", icon: "camera.viewfinder") {
            print("预览：实物扫描按钮被点击了")
        },
        // "辞典查询" 按钮
        FunctionItem(title: "辞典查询", icon: "magnifyingglass") {
            print("预览：辞典查询按钮被点击了")
        }
    ]
    //    用于控制选中的tab的状态变量
    @State private var selectedTab: MasterPerformanceTab = .classicVideos
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading) {
                
                Text("名琴博物馆")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                
                HStack {
                    FunctionalButtonsSection(sectionTitle: nil, functionItems: previewItems)
                        .padding(.bottom)
                }
                .frame(width:.infinity)
                
                HStack {
                    Text("大师演奏")
                        .font(.title2)
                        .padding()
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        print("更多大师演奏内容")
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,4)
                
                //                tab选择器
                Picker("choose mode", selection: $selectedTab){
                    ForEach(MasterPerformanceTab.allCases){tab in
                        Text(tab.rawValue)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom,8)
                
                Group {
                    switch selectedTab {
                    case .classicVideos:
                        // 这里放置 "经典影像" 的内容，例如你的 RecommendationSection
                        // 为了演示，我先放一个简单的 Text
                        // 你可能需要一个 RecommendationSection(viewModel: ...)
                        Text("经典影像内容展示区域")
                            .frame(maxWidth: .infinity)
                            .frame(height: 200) // 示例高度
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    case .animatedShadows:
                        Text("动画剪影内容展示区域")
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    case .communityShare:
                        Text("社区分享内容展示区域")
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom) // 内容区域底部间距
                
                HStack {
                    Text("动态曲谱")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        print("更多动态曲谱内容")
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,4)
                
                
            }
        }
    }
}

#Preview {
    AppreciationView()
}
