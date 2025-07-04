//
//  Extensions.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/27.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}


extension UIImage {
    /// 调整图片大小
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension Font.Weight: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        switch stringValue {
        case "ultraLight": self = .ultraLight
        case "thin": self = .thin
        case "light": self = .light
        case "regular": self = .regular
        case "medium": self = .medium
        case "semibold": self = .semibold
        case "bold": self = .bold
        case "heavy": self = .heavy
        case "black": self = .black
        default:
            // 处理未知字符串，可以抛出错误或设置默认值
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid Font.Weight raw value: \(stringValue)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var stringValue: String
        switch self {
        case .ultraLight: stringValue = "ultraLight"
        case .thin: stringValue = "thin"
        case .light: stringValue = "light"
        case .regular: stringValue = "regular"
        case .medium: stringValue = "medium"
        case .semibold: stringValue = "semibold"
        case .bold: stringValue = "bold"
        case .heavy: stringValue = "heavy"
        case .black: stringValue = "black"
        default:
            // Fallback for any future Font.Weight cases or if .system() is used
            // For now, these cover all standard cases.
            stringValue = "regular" // Or throw an error if strictness is needed
        }
        try container.encode(stringValue)
    }
}
