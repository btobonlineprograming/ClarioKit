//
//  ClarioKit.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/4/25.
//

import Foundation

public final class ClarioEngine {
    let model: ClarioModel
    
    public init(model: ClarioModel) {
        self.model = model
    }
    
    public func summarize(document: ClarioDocument) async throws -> String {
        switch(model) {
        case .foundation:
            
//            if #available(iOS 26.0, *) {
//                let provider = FoundationModelsProvider()
//                return try await provider.summarize(document: document)
//            } else {
//                throw ClarioKitError.unavailableModel
//            }
            
            print("Not supported yet")
            throw ClarioKitError.unsupportedModel
        case .openAI:
            throw ClarioKitError.unsupportedModel
        case .gemini(let apiKey):
            let provider = GeminiProvider(apiKey: apiKey)
            return try await provider.summarize(document: document)
        @unknown default:
            throw ClarioKitError.unsupportedModel
        }
    }
}

