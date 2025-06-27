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
    
    @StateObject private var scoreSectionViewModel = ScoreSectionViewModel()
    
    @StateObject private var classicVideoViewModel = ClassicVideoViewModel()
    
    var body: some View {
           NavigationStack {
               ScrollView(.vertical, showsIndicators: false) {
                   VStack(alignment: .leading) {
                       
                       
                       HStack {
                           FunctionalButtonsSection(sectionTitle: nil, functionItems: previewItems)
                               .padding(.bottom)
                       }
                       .frame(maxWidth: .infinity) // 确保 FunctionalButtonsSection 填满宽度
                       
                       HStack {
                           Text("大师演奏")
                               .font(.title2)
                               .padding(.leading) // 保持与其他标题一致的左边距
                               .padding(.vertical, 0)
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
                       
                       // tab选择器
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
                               ClassicVideoSection(sectionTitle: nil, showMoreButton: false, viewModel: classicVideoViewModel)
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
                               .padding(.leading) // 保持与其他标题一致的左边距
                               .padding(.vertical, 0)
                           
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
                       
                      
                       ScoreSection(sectionTitle: nil, showMoreButton: false, viewModel: scoreSectionViewModel)
                       
                       Spacer()
                   }
               }
               // <--- 可选: 设置 NavigationStack 的导航栏标题
               .navigationTitle("名琴博物馆") // 主页标题
               .navigationBarTitleDisplayMode(.large)
               .background(Color("BackgroundPrimary").ignoresSafeArea()) // 确保背景色填充整个屏幕
           }
       }
   }

#Preview {
    AppreciationView()
}
