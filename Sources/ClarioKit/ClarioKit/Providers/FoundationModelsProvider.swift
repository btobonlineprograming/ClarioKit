//
//  FoundationModelsProvider.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/4/25.
//

import Foundation
//import FoundationModels


#if canImport(FoundationModels)
@available(iOS 26.0, *)
public class FoundationModelsProvider {
    
    private var model = SystemLanguageModel.default
    
    public func summarize(document: ClarioDocument) async throws -> String {
        let rawText = document.rawText
        switch model.availability {
        case .available:
            let instructions = ClarioConstant.summarize

             let session = LanguageModelSession(instructions: instructions)
            
            let prompt = """
            Document:
            \(rawText)
            """
            let response = try await session.respond(to: prompt)
            
            return response.content
        case .unavailable(_):
            throw ClarioKitError.unavailableModel
        }
        
    }
    
}
#endif
