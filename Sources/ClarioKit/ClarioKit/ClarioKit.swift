//
//  ClarioKit.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/4/25.
//

import Foundation

public final class ClarioKit {
    let model: ClarioModel
    
    public init(model: ClarioModel) {
        self.model = model
    }
    
    public func summarize(document: ClarioDocument) async throws -> String {
        switch(model) {
        case .foundation:
            
            if #available(iOS 26.0, *) {
//                let provider = FoundationModelsProvider()
//                return try await provider.summarize(document: document)
            } else {
                throw ClarioKitError.unavailableModel
            }
            
            throw ClarioKitError.unsupportedModel
            
        case .openAI(_):
            
            throw ClarioKitError.unsupportedModel
        
        case .gemini(let apiKey):
            
            if #available(iOS 13.0, *) {
                let provider = GeminiProvider(apiKey: apiKey)
                return try await provider.summarize(document: document)}
            else {
                throw ClarioKitError.unavailableModel
            }
            
        @unknown default:
            throw ClarioKitError.unsupportedModel
        }
    }
}

