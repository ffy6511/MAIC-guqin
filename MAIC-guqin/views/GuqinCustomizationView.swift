//
//  GuqinCustomizationView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/4.
//

import SwiftUI

struct GuqinCustomizationView: View {
    @StateObject private var viewModel = GuqinCustomizationViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // 主要内容区域
                    HStack(spacing: 0) {
                        // 左侧边栏 - 琴身定制
                        leftSidebar
                            .frame(width: 80)
                        
                        // 中央预览区域
                        centerPreviewArea
                            .frame(maxWidth: .infinity)
                        
                        // 右侧边栏 - 琴弦定制
                        rightSidebar
                            .frame(width: 80)
                    }
                    .frame(maxHeight: .infinity)
                    
                    // 底部选择面板
                    CustomizationOptionSelector(viewModel: viewModel)
                        .frame(height: 140)
                }
            }
            .navigationTitle("古琴定制")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {
                            viewModel.togglePreviewMode()
                        }) {
                            Image(systemName: "eye")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        
                        Button(action: {
                            viewModel.resetToDefault()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(hex: "#9BB1A8").opacity(0.3), location: 0),
                        .init(color: Color(hex: "#FFFFFF").opacity(0.5), location: 0.3),
                        .init(color: Color(hex: "#EDF1EF").opacity(0.5), location: 0.7),
                        .init(color: Color(hex: "#9BB1A8").opacity(0.3), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - 左侧边栏
    private var leftSidebar: some View {
        VStack(spacing: 16) {
            Text("琴身")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            
            VStack(spacing: 12) {
                ForEach(viewModel.bodyCategories) { category in
                    CategoryIconButton(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.selectCategory(category)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground).opacity(0.8))
                .shadow(color: .black.opacity(0.05), radius: 3, x: 2, y: 0)
        )
        .padding(.vertical, 16)
        .padding(.leading, 8)
    }
    
    // MARK: - 右侧边栏
    private var rightSidebar: some View {
        VStack(spacing: 16) {
            Text("琴弦")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            
            VStack(spacing: 12) {
                ForEach(viewModel.stringsCategories) { category in
                    CategoryIconButton(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.selectCategory(category)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground).opacity(0.8))
                .shadow(color: .black.opacity(0.05), radius: 3, x: -2, y: 0)
        )
        .padding(.vertical, 16)
        .padding(.trailing, 8)
    }
    
    // MARK: - 中央预览区域
    private var centerPreviewArea: some View {
        VStack {
            Spacer()
            
            // 古琴预览
            GuqinPreviewView(
                shapeImageName: viewModel.currentShapeImageName,
                materialTextureImageName: viewModel.currentMaterialTextureImageName,
                materialBaseColor: viewModel.currentMaterialBaseColor,
                materialBlendMode: viewModel.currentMaterialBlendMode,
                stringsImageName: viewModel.currentStringsImageName,
                stringsMaterialColor: viewModel.currentStringsMaterialColor,
                inscription: viewModel.currentConfiguration.inscription,
                isShowingBack: viewModel.currentConfiguration.isShowingBack
            )
            .scaleEffect(viewModel.isPreviewMode ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.3), value: viewModel.isPreviewMode)
            
            // 配置信息
            VStack(spacing: 4) {
                Text(viewModel.currentConfiguration.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                if viewModel.isPreviewMode {
                    Text("预览模式")
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color.blue.opacity(0.1))
                        )
                }
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    GuqinCustomizationView()
}
