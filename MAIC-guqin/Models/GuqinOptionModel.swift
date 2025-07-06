//
//  GuqinOptionModel.swift
//  MAIC-guqin
//
//  Created by AI Assistant on 2025/7/4.
//

import SwiftUI

// MARK: - 古琴形制枚举
enum GuqinShape: String, CaseIterable, Identifiable, Codable {
    case fuxi = "伏羲式"
    case hundun = "混沌式"
    case zhenghe = "正和式"
    case zhongni = "仲尼式"
    case liezi = "列子式"

    var id: String { self.rawValue }

    /// 形制图片名称（既用于显示轮廓，也用于材质蒙版）
    var imageName: String {
        switch self {
        case .fuxi:
            return "guqin_fuxi"
        case .hundun:
            return "guqin_hundun"
        case .zhenghe:
            return "guqin_zhenghe"
        case .zhongni:
            return "guqin_zhongni"
        case .liezi:
            return "guqin_liezi"
        }
    }

    /// 形制图标名称（用于选择按钮）
    var iconName: String {
        switch self {
        case .fuxi:
            return "guqin_icon_fuxi"
        case .hundun:
            return "guqin_icon_hundun"
        case .zhenghe:
            return "guqin_icon_zhenghe"
        case .zhongni:
            return "guqin_icon_zhongni"
        case .liezi:
            return "guqin_icon_liezi"
        }
    }
}

// MARK: - 古琴材质类型枚举
enum GuqinMaterialType: String, CaseIterable, Identifiable, Codable {
    case blackLacquer = "黑漆"
    case brownLacquer = "棕漆"
    case redLacquer = "红漆"
    case woodGrain = "木纹"
    case flowerDecoration = "花饰"

    var id: String { self.rawValue }

    /// 材质纹理图片名称
    var textureImageName: String {
        switch self {
        case .blackLacquer:
            return "material_texture_black_lacquer"
        case .brownLacquer:
            return "material_texture_brown_lacquer"
        case .redLacquer:
            return "material_texture_red_lacquer"
        case .woodGrain:
            return "material_texture_wood_grain"
        case .flowerDecoration:
            return "material_texture_flower_decoration"
        }
    }

    /// 材质基础颜色（用于预览和占位）
    var baseColor: Color {
        switch self {
        case .blackLacquer:
            return Color.black
        case .brownLacquer:
            return Color.brown
        case .redLacquer:
            return Color.red
        case .woodGrain:
            return Color.brown.opacity(0.8)
        case .flowerDecoration:
            return Color.purple.opacity(0.6)
        }
    }

    /// 混合模式
    var blendMode: BlendMode {
        switch self {
        case .blackLacquer, .brownLacquer, .redLacquer:
            return .normal
        case .woodGrain:
            return .multiply
        case .flowerDecoration:
            return .overlay
        }
    }

    /// 缩略图名称（用于选择按钮）
    var thumbnailImageName: String {
        switch self {
        case .blackLacquer:
            return "material_thumbnail_black_lacquer"
        case .brownLacquer:
            return "material_thumbnail_brown_lacquer"
        case .redLacquer:
            return "material_thumbnail_red_lacquer"
        case .woodGrain:
            return "material_thumbnail_wood_grain"
        case .flowerDecoration:
            return "material_thumbnail_flower_decoration"
        }
    }
}

// MARK: - 古琴琴弦数量枚举
enum GuqinStringsCount: String, CaseIterable, Identifiable, Codable {
    case sevenStrings = "七弦"
    case fiveStrings = "五弦"

    var id: String { self.rawValue }

    /// 对应的琴弦图片名称
    var stringsImageName: String {
        switch self {
        case .sevenStrings:
            return "guqin_strings_7"
        case .fiveStrings:
            return "guqin_strings_5"
        }
    }

    /// 琴弦图标名称（用于选择按钮）
    var iconName: String {
        switch self {
        case .sevenStrings:
            return "strings_7_icon"
        case .fiveStrings:
            return "strings_5_icon"
        }
    }

    /// 实际弦数
    var count: Int {
        switch self {
        case .sevenStrings:
            return 7
        case .fiveStrings:
            return 5
        }
    }
}

// MARK: - 琴弦材质枚举
enum GuqinStringsMaterial: String, CaseIterable, Identifiable, Codable {
    case nylon = "尼龙弦"
    case silk = "丝弦"
    case steel = "钢弦"

    var id: String { self.rawValue }

    /// 材质颜色（用于琴弦着色）
    var materialColor: Color {
        switch self {
        case .nylon:
            return Color.white.opacity(0.9)
        case .silk:
            return Color.yellow.opacity(0.8)
        case .steel:
            return Color.gray.opacity(0.8)
        }
    }
    
    /// 材质图片名称（用于选择按钮）
    var materialImageName: String {
        switch self {
        case .nylon:
            return "strings_material_nylon"
        case .silk:
            return "strings_material_silk"
        case .steel:
            return "strings_material_steel"
        }
    }
}

// MARK: - 铭文结构
struct GuqinInscription: Codable, Equatable {
    var text: String
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var position: InscriptionPosition

    static let `default` = GuqinInscription(
        text: "",
        fontSize: 16,
        fontWeight: .regular,
        position: .center
    )

    enum InscriptionPosition: String, CaseIterable, Codable, Identifiable {
        var id: String { self.rawValue }
        case topLeft = "左上"
        case topCenter = "上中"
        case topRight = "右上"
        case center = "居中"
        case bottomLeft = "左下"
        case bottomCenter = "下中"
        case bottomRight = "右下"
    }
}

// MARK: - 音准设置结构
struct GuqinTuning: Codable, Equatable {
    var stringTunings: [Double] // 每根弦的音准值 (0.0 - 1.0)

    static let defaultSevenStrings = GuqinTuning(
        stringTunings: [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
    )

    static let defaultFiveStrings = GuqinTuning(
        stringTunings: [0.5, 0.5, 0.5, 0.5, 0.5]
    )

    /// 根据弦数获取默认音准
    static func defaultTuning(for stringsCount: GuqinStringsCount) -> GuqinTuning {
        switch stringsCount {
        case .sevenStrings:
            return defaultSevenStrings
        case .fiveStrings:
            return defaultFiveStrings
        }
    }
}

// MARK: - 定制类别枚举
enum CustomizationCategory: String, CaseIterable, Identifiable {
    case shape = "形制"
    case material = "材质"
    case inscription = "铭文"
    case stringsCount = "弦数"
    case stringsMaterial = "弦材质"
    case tuning = "音准"

    var id: String { self.rawValue }

    /// 类别图标名称
    var iconName: String {
        switch self {
        case .shape:
            return "shape_category_icon"
        case .material:
            return "material_category_icon"
        case .inscription:
            return "inscription_category_icon"
        case .stringsCount:
            return "strings_count_category_icon"
        case .stringsMaterial:
            return "strings_material_category_icon"
        case .tuning:
            return "tuning_category_icon"
        }
    }

    /// 是否属于琴身类别
    var isBodyCategory: Bool {
        switch self {
        case .shape, .material, .inscription:
            return true
        case .stringsCount, .stringsMaterial, .tuning:
            return false
        }
    }
}

// MARK: - 古琴配置结构体
struct GuqinConfiguration: Codable, Equatable {
    var shape: GuqinShape
    var material: GuqinMaterialType
    var inscription: GuqinInscription
    var stringsCount: GuqinStringsCount
    var stringsMaterial: GuqinStringsMaterial
    var tuning: GuqinTuning
    var isShowingBack: Bool // 是否显示背面（用于铭文编辑）

    /// 默认配置
    // 使用 ' 避免成为关键字处理
    static let `default` = GuqinConfiguration(
        shape: .fuxi,
        material: .blackLacquer,
        inscription: .default,
        stringsCount: .sevenStrings,
        stringsMaterial: .nylon,
        tuning: .defaultSevenStrings,
        isShowingBack: false
    )

    /// 配置名称（用于保存和显示）
    var displayName: String {
        return "\(shape.rawValue) · \(material.rawValue) · \(stringsCount.rawValue)"
    }

    /// 根据弦数更新音准设置
    mutating func updateTuningForStringsCount() {
        tuning = GuqinTuning.defaultTuning(for: stringsCount)
    }
}
