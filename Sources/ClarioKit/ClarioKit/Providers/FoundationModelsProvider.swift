//
//  FoundationModelsProvider.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/4/25.
//

import Foundation
import FoundationModels


#if canImport(FoundationModels)
@available(iOS 26.0, *)
public class FoundationModelsProvider {
    
    private var model = SystemLanguageModel.default
    
    public func summarize(document: ClarioDocument) async throws -> String {
        let rawText = document.rawText
        switch model.availability {
        case .available:
            let instructions = """
            You are a helpful assistant specialized in reading and summarizing documents.

            Summarize the provided document clearly and concisely. Focus on the key ideas, important details, and general purpose of the text.

            Avoid unnecessary repetition, and do not include formatting from the original file.
            Limit the summary to a few concise paragraphs.
            """

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
