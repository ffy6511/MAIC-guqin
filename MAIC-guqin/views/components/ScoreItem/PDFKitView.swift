//
//  PDFKitView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/4.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.backgroundColor = .clear
        
        // 调试输出
//        print("PDFKitView: 尝试加载PDF文件: \(url)")
//        print("PDFKitView: 文件是否存在: \(FileManager.default.fileExists(atPath: url.path))")
        
        if let document = PDFDocument(url: url) {
            pdfView.document = document
            print("PDFKitView: PDF文档加载成功，页数: \(document.pageCount)")
        }
        
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        // 不需要动态更新
    }
}
