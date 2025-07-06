//
//  GuqinCustomizationViewModel.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/4.
//

import SwiftUI
import Combine

class GuqinCustomizationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var currentConfiguration: GuqinConfiguration = .default
    @Published var selectedCategory: CustomizationCategory = .shape
    @Published var isPreviewMode: Bool = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init() {
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        // 监听配置变化，可以在这里添加保存逻辑
        $currentConfiguration
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] configuration in
                self?.saveConfiguration(configuration)
            }
            .store(in: &cancellables) // 保持订阅有效
    }
    
    private func saveConfiguration(_ configuration: GuqinConfiguration) {
        // TODO: 实现配置保存逻辑
        print("保存配置: \(configuration.displayName)")
    }
    
    // MARK: - Public Methods - 用户操作
    
    /// 选择古琴形制
    func selectShape(_ shape: GuqinShape) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentConfiguration.shape = shape
        }
        
        // TODO: 检查触觉反馈的开关
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    /// 选择古琴材质
    func selectMaterial(_ material: GuqinMaterialType) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentConfiguration.material = material
        }
        
        // 触觉反馈
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    /// 选择琴弦数量
    func selectStringsCount(_ stringsCount: GuqinStringsCount) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentConfiguration.stringsCount = stringsCount
            currentConfiguration.updateTuningForStringsCount()
        }

        // 触觉反馈
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }

    /// 选择琴弦材质
    func selectStringsMaterial(_ stringsMaterial: GuqinStringsMaterial) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentConfiguration.stringsMaterial = stringsMaterial
        }

        // 触觉反馈
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }

    /// 更新铭文
    func updateInscription(_ inscription: GuqinInscription) {
        withAnimation(.easeInOut(duration: 0.2)) {
            currentConfiguration.inscription = inscription
        }
    }

    /// 更新音准设置
    func updateTuning(_ tuning: GuqinTuning) {
        currentConfiguration.tuning = tuning
    }

    /// 切换显示背面（用于铭文编辑）
    func toggleShowingBack() {
        currentConfiguration.isShowingBack.toggle()

        // 触觉反馈
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    /// 选择定制类别
    func selectCategory(_ category: CustomizationCategory) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedCategory = category
        }
        
        // 轻触觉反馈
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    /// 重置配置到默认值
    func resetToDefault() {
        withAnimation(.easeInOut(duration: 0.5)) {
            currentConfiguration = .default
            selectedCategory = .shape
        }
        
        // 触觉反馈
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
    }
    
    /// 切换预览模式
    func togglePreviewMode() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isPreviewMode.toggle()
        }
    }
    
    // MARK: - Computed Properties - 方便视图使用

    /// 当前选定形制的图片名称
    var currentShapeImageName: String {
        return currentConfiguration.shape.imageName
    }

    /// 当前选定材质的纹理图片名称
    var currentMaterialTextureImageName: String {
        return currentConfiguration.material.textureImageName
    }

    /// 当前选定材质的基础颜色
    var currentMaterialBaseColor: Color {
        return currentConfiguration.material.baseColor
    }

    /// 当前选定材质的混合模式
    var currentMaterialBlendMode: BlendMode {
        return currentConfiguration.material.blendMode
    }

    /// 当前选定弦数的图片名称
    var currentStringsImageName: String {
        return currentConfiguration.stringsCount.stringsImageName
    }

    /// 当前选定琴弦材质的颜色
    var currentStringsMaterialColor: Color {
        return currentConfiguration.stringsMaterial.materialColor
    }
    
    /// 当前选中类别对应的选项列表
    var currentCategoryOptions: [Any] {
        switch selectedCategory {
        case .shape:
            return GuqinShape.allCases
        case .material:
            return GuqinMaterialType.allCases
        case .stringsCount:
            return GuqinStringsCount.allCases
        case .stringsMaterial:
            return GuqinStringsMaterial.allCases
        case .inscription, .tuning:
            return [] // 这些类别使用特殊的UI组件
        }
    }
    
    /// 琴身类别列表
    var bodyCategories: [CustomizationCategory] {
        return CustomizationCategory.allCases.filter { $0.isBodyCategory }
    }
    
    /// 琴弦类别列表
    var stringsCategories: [CustomizationCategory] {
        return CustomizationCategory.allCases.filter { !$0.isBodyCategory }
    }
    
    /// 检查某个选项是否被选中
    func isSelected<T: Equatable>(_ option: T, in category: CustomizationCategory) -> Bool {
        switch category {
        case .shape:
            if let shape = option as? GuqinShape {
                return currentConfiguration.shape == shape
            }
        case .material:
            if let material = option as? GuqinMaterialType {
                return currentConfiguration.material == material
            }
        case .stringsCount:
            if let stringsCount = option as? GuqinStringsCount {
                return currentConfiguration.stringsCount == stringsCount
            }
        case .stringsMaterial:
            if let stringsMaterial = option as? GuqinStringsMaterial {
                return currentConfiguration.stringsMaterial == stringsMaterial
            }
        default:
            break
        }
        return false
    }
}
