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
                    // 古琴预览区域
                    centerPreviewArea
                        .frame(maxHeight: .infinity)

                    // 类别选择滚动条
                    categoryScrollView
                        .frame(height: 80)
                        .padding(.vertical, 8)

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
                    HStack(spacing: 8) {
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
                        .init(color: Color(hex: "#9BB1A8").opacity(0.75), location: 0),
                        .init(color: Color(hex: "#FFFFFF").opacity(0.75), location: 0.21),
                        .init(color: Color(hex: "#EDF1EF").opacity(0.75), location: 0.80),
                        .init(color: Color(hex: "#9BB1A8").opacity(0.75), location: 0.96)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - 类别选择滚动视图
    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(CustomizationCategory.allCases) { category in
                    CategoryIconButton(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.selectCategory(category)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical,8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground).opacity(0.8))
                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
    }
    
    // MARK: - 中央预览区域
    private var centerPreviewArea: some View {
        VStack(spacing: 16) {
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

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    GuqinCustomizationView()
}
