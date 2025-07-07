//
//  GeminiProvider.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/7/25.
//

import Foundation

public class GeminiProvider {
    
    var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func summarize(document: ClarioDocument) async throws -> String {
        do {
            let pdfData = try Data(contentsOf: document.sourceURL)
            let base64PDF = pdfData.base64EncodedString()
            
            let promptPart = PartOrData.text(ClarioConstant.summarize)
            let pdfPart = PartOrData.inlineData(.init(mimeType: "application/pdf", data: base64PDF))
            
            let requestBody = GenerateContentRequest(contents: [
                GeminiContent(parts: [promptPart, pdfPart])
            ])
            
            var urlComponents = URLComponents(string: ClarioConstant.geminiURL)!
            urlComponents.queryItems = [
                URLQueryItem(name: "key", value: self.apiKey)
            ]
            
            guard let url = urlComponents.url else {
                throw ClarioNetworkError.invalidURL
            }
            
            let response: GenerateContentResponse = try await ClarioNetworkManager.shared.post(url: url, body: requestBody)
            
            if let summary = response.candidates.first?.content.parts.first?.text {
               return summary
            } else {
                throw ClarioKitError.unavailableModel
            }
            
        } catch(let error) {
            throw error
        }
    }
    
}
