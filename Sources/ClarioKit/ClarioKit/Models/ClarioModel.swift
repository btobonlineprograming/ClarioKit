//
//  ClarioModel.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/4/25.
//

import Foundation

public enum ClarioModel {
    case foundation
    case openAI(apiKey: String)
    case gemini(apiKey: String)
}

