//
//  GuqinComponents.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/4.
//

import SwiftUI

// MARK: - 古琴预览视图
struct GuqinPreviewView: View {
    let shapeImageName: String
    let materialTextureImageName: String
    let materialBaseColor: Color
    let materialBlendMode: BlendMode
    let stringsImageName: String
    let stringsMaterialColor: Color
    let inscription: GuqinInscription
    let isShowingBack: Bool

    var body: some View {
        ZStack {
            if isShowingBack {
                // 背面视图 - 用于显示铭文
                backView
            } else {
                // 正面视图 - 正常的古琴预览
                frontView
            }
        }
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 0.5), value: isShowingBack)
        .rotation3DEffect(
            .degrees(isShowingBack ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
    }

    // MARK: - 正面视图
    private var frontView: some View {
        ZStack {
            // 1. 最底层：形制轮廓（也作为基础）
            Image(shapeImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 280, maxHeight: 400)

            // 2. 材质层：使用形制图片作为蒙版
            Image(materialTextureImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .mask(
                    Image(shapeImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                )
                .blendMode(materialBlendMode)
                .frame(maxWidth: 280, maxHeight: 400)

            // 3. 琴弦层：在最顶层，带材质颜色效果
            Image(stringsImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorMultiply(stringsMaterialColor)
                .frame(maxWidth: 240, maxHeight: 350)
                .offset(x:3)
        }
    }

    // MARK: - 背面视图
    private var backView: some View {
        GeometryReader{ proxy in
            ZStack {
                // 背面形制轮廓
                Image(shapeImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 280, maxHeight: 400)
                    .scaleEffect(x: -1, y: 1) // 水平翻转
                
                // 背面材质
                Image(materialTextureImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .mask(
                        Image(shapeImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(x: -1, y: 1) // 水平翻转
                    )
                    .blendMode(materialBlendMode)
                    .frame(maxWidth: 280, maxHeight: 400)
                
                // 铭文显示
               
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
//            .rotation3DEffect(.degrees(180), axis: (x:0, y:1, z:0))
            .overlay(alignment: .center){
                if !inscription.text.isEmpty {
                    inscriptionView(proxy: proxy)
                }
            }
            }
        }

    // MARK: - 铭文视图
    private func inscriptionView(proxy: GeometryProxy)-> some View {
        Text(inscription.text)
            .applyFontStyle(
                style: inscription.fontStyle,
                size: inscription.fontSize,
                weight: inscription.fontWeight
            )
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: 200, maxHeight: 300)
            .position(inscriptionPosition(proxy:proxy))
            .scaleEffect(x: -1, y: 1)
    }
    

    // MARK: - 铭文位置计算
    private func inscriptionPosition(proxy: GeometryProxy)-> CGPoint {
        let centerX: CGFloat = proxy.size.width / 2
        let centerY: CGFloat = proxy.size.height / 2

        switch inscription.position {
        case .topLeft:
            return CGPoint(x: centerX - 80, y: centerY - 120)
        case .topCenter:
            return CGPoint(x: centerX, y: centerY - 120)
        case .topRight:
            return CGPoint(x: centerX + 80, y: centerY - 120)
        case .center:
            return CGPoint(x: centerX, y: centerY)
        case .bottomLeft:
            return CGPoint(x: centerX - 80, y: centerY + 120)
        case .bottomCenter:
            return CGPoint(x: centerX, y: centerY + 120)
        case .bottomRight:
            return CGPoint(x: centerX + 80, y: centerY + 120)
        }
    }
}

// MARK: - 选项缩略图按钮
struct OptionThumbnailButton: View {
    let thumbnailImage: Image?
    let thumbnailColor: Color?
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private let buttonSize: CGFloat = 60
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack(spacing: 4) {
                // 缩略图区域
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: buttonSize, height: buttonSize)
                    
                    if let thumbnailImage = thumbnailImage {
                        thumbnailImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: buttonSize - 4, height: buttonSize - 4)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    } else if let thumbnailColor = thumbnailColor {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(thumbnailColor)
                            .frame(width: buttonSize - 8, height: buttonSize - 8)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            isSelected ? Color.accentColor : Color.clear,
                            lineWidth: isSelected ? 2 : 0
                        )
                )
                .scaleEffect(isSelected ? 1.05 : 1.0)
                
                // 标题文字
                Text(title)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .accentColor : .secondary)
                    .lineLimit(1)
                    .frame(width: buttonSize)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .padding(.vertical,4)
    }
}

// MARK: - 类别图标按钮
struct CategoryIconButton: View {
    let category: CustomizationCategory
    let isSelected: Bool
    let action: () -> Void
    
    private let iconSize: CGFloat = 44
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.1))
                        .frame(width: iconSize, height: iconSize)
                    
                    Image(systemName: systemIconName)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(isSelected ? .accentColor : .secondary)
                }
                .scaleEffect(isSelected ? 1.05 : 1.0)
                
                Text(category.rawValue)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .accentColor : .secondary)
                    .lineLimit(1)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
    
    private var systemIconName: String {
        switch category {
        case .shape:
            return "rectangle.3.group"
        case .material:
            return "paintbrush.fill"
        case .inscription:
            return "text.word.spacing"
        case .stringsCount:
            return "waveform"
        case .stringsMaterial:
            return "fiberchannel"
        case .tuning:
            return "tuningfork"
        }
    }
}

// MARK: - 定制选项选择器
struct CustomizationOptionSelector: View {
    @ObservedObject var viewModel: GuqinCustomizationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            // 当前类别标题
//            HStack {
//                Text(viewModel.selectedCategory.rawValue)
//                    .font(.headline)
//                    .foregroundColor(.primary)
//                
//                Spacer()
//                
//                Text("选择合适的\(viewModel.selectedCategory.rawValue)")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//            .padding(.horizontal)
            
            // 选项滚动视图
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    switch viewModel.selectedCategory {
                    case .shape:
                        ForEach(GuqinShape.allCases) { shape in
                            OptionThumbnailButton(
                                thumbnailImage: Image(shape.iconName),
                                thumbnailColor: nil,
                                title: shape.rawValue,
                                isSelected: viewModel.isSelected(shape, in: .shape)
                            ) {
                                viewModel.selectShape(shape)
                            }
                        }

                    case .material:
                        ForEach(GuqinMaterialType.allCases) { material in
                            OptionThumbnailButton(
                                thumbnailImage: Image(material.thumbnailImageName),
                                thumbnailColor: material.baseColor, // 仅用于预览
                                title: material.rawValue,
                                isSelected: viewModel.isSelected(material, in: .material)
                            ) {
                                viewModel.selectMaterial(material)
                            }
                        }

                    case .stringsCount:
                        ForEach(GuqinStringsCount.allCases) { stringsCount in
                            OptionThumbnailButton(
                                thumbnailImage: Image(stringsCount.iconName),
                                thumbnailColor: nil,
                                title: stringsCount.rawValue,
                                isSelected: viewModel.isSelected(stringsCount, in: .stringsCount)
                            ) {
                                viewModel.selectStringsCount(stringsCount)
                            }
                        }

                    case .stringsMaterial:
                        ForEach(GuqinStringsMaterial.allCases) { stringsMaterial in
                            OptionThumbnailButton(
                                thumbnailImage: Image(stringsMaterial.materialImageName),
                                thumbnailColor: stringsMaterial.materialColor,
                                title: stringsMaterial.rawValue,
                                isSelected: viewModel.isSelected(stringsMaterial, in: .stringsMaterial)
                            ) {
                                viewModel.selectStringsMaterial(stringsMaterial)
                            }
                        }

                    case .inscription:
                        InscriptionEditor(viewModel: viewModel)

                    case .tuning:
                        TuningEditor(viewModel: viewModel)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
        )
    }
}

// MARK: - 铭文编辑器
struct InscriptionEditor: View {
    @ObservedObject var viewModel: GuqinCustomizationViewModel
    @State private var inscriptionText: String = ""
    @State private var selectedPosition: GuqinInscription.InscriptionPosition = .center
    @State private var fontSize: CGFloat = 16
    @State private var selectedFontStyle: InscriptionFontStyle = .system

    var body: some View {
        VStack(spacing: 16) {
            // 切换到背面按钮
            Button(action: {
                viewModel.toggleShowingBack()
            }) {
                HStack {
                    Image(systemName: viewModel.currentConfiguration.isShowingBack ? "eye.slash" : "eye")
                    Text(viewModel.currentConfiguration.isShowingBack ? "查看正面" : "查看背面")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(8)
            }

            if viewModel.currentConfiguration.isShowingBack {
                VStack(spacing: 12) {
                    // 铭文输入
                    TextField("输入铭文", text: $inscriptionText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: inscriptionText) {
                            updateInscription()
                        }

                    // 位置选择
                    VStack(alignment: .leading, spacing: 8) {
                        Text("位置")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                            ForEach(GuqinInscription.InscriptionPosition.allCases) { position in
                                Button(action: {
                                    selectedPosition = position
                                    updateInscription()
                                }) {
                                    Text(position.rawValue)
                                        .font(.caption2)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(selectedPosition == position ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                        )
                                        .foregroundColor(selectedPosition == position ? .blue : .secondary)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }

                    // 字体大小
                    VStack(alignment: .leading, spacing: 8) {
                        Text("字体大小: \(Int(fontSize))")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Slider(value: $fontSize, in: 12...24, step: 1)
                            .onChange(of: fontSize) {
                                updateInscription()
                            }
                    }
                    
                    // 字体样式
                    VStack(alignment: .leading, spacing: 8){
                        Text("字体样式")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Picker("字体样式",selection: $selectedFontStyle){
                            ForEach(InscriptionFontStyle.allCases){style in
                                Text(style.rawValue).tag(style)}
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: selectedFontStyle){
                            updateInscription()
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
            }
        }
        .onAppear {
            inscriptionText = viewModel.currentConfiguration.inscription.text
            selectedPosition = viewModel.currentConfiguration.inscription.position
            fontSize = viewModel.currentConfiguration.inscription.fontSize
            selectedFontStyle = viewModel.currentConfiguration.inscription.fontStyle
        }
    }

    private func updateInscription() {
        let inscription = GuqinInscription(
            text: inscriptionText,
            fontSize: fontSize,
            fontWeight: .regular,
            position: selectedPosition,
            fontStyle: selectedFontStyle
        )
        viewModel.updateInscription(inscription)
    }
}

// MARK: - 音准编辑器
struct TuningEditor: View {
    @ObservedObject var viewModel: GuqinCustomizationViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("音准调节")
                .font(.headline)
                .foregroundColor(.primary)

            VStack(spacing: 12) {
                ForEach(0..<viewModel.currentConfiguration.tuning.stringTunings.count, id: \.self) { index in
                    HStack {
                        Text("第\(index + 1)弦")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(width: 50, alignment: .leading)

                        Slider(
                            value: Binding(
                                get: { viewModel.currentConfiguration.tuning.stringTunings[index] },
                                set: { newValue in
                                    var tuning = viewModel.currentConfiguration.tuning
                                    tuning.stringTunings[index] = newValue
                                    viewModel.updateTuning(tuning)
                                }
                            ),
                            in: 0.0...1.0
                        )
                        .accentColor(.blue)

                        Text("\(Int(viewModel.currentConfiguration.tuning.stringTunings[index] * 100))%")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .frame(width: 40, alignment: .trailing)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)

            // 重置按钮
            Button(action: {
                let defaultTuning = GuqinTuning.defaultTuning(for: viewModel.currentConfiguration.stringsCount)
                viewModel.updateTuning(defaultTuning)
            }) {
                Text("重置音准")
                    .font(.caption)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(.secondary)
                    .cornerRadius(6)
            }
        }
    }
}
