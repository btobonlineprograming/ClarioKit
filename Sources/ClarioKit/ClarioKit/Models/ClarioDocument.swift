//
//  ClarioDocument.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/4/25.
//
import Foundation
import PDFKit

public enum DocumentType {
    case pdf(URL)
    case docx(URL)
}

public struct ClarioDocument {
    public let rawText: String
    
    public init(from file: DocumentType) throws {
        switch(file) {
        case .pdf(let src):
            rawText = Self.extractText(pdfURL: src)
        case .docx(let src):
            rawText = Self.extractText(docxURL: src)
        }
    }
    
    private static func extractText(pdfURL: URL) -> String {
        guard let pdf = PDFDocument(url: pdfURL) else {
            return ""
        }

        var documentContent = ""
        let pageCount = pdf.pageCount

        for i in 0..<pageCount {
            guard let page = pdf.page(at: i) else {
                continue
            }
            if let pageText = page.string {
                documentContent += pageText
            }
        }

        return documentContent
    }
    
    private static func extractText(docxURL: URL) -> String {
        return "" // TODO: Implement docx extraction
    }
}
