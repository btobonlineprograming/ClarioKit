//
//  ClarioGeminiModel.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/7/25.
//

struct InlineData: Codable {
    let mimeType: String
    let data: String
}

enum PartOrData: Codable {
    case text(String)
    case inlineData(InlineData)

    enum CodingKeys: String, CodingKey {
        case text
        case inlineData
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .text(let value):
            try container.encode(value, forKey: .text)
        case .inlineData(let value):
            try container.encode(value, forKey: .inlineData)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let text = try? container.decode(String.self, forKey: .text) {
            self = .text(text)
        } else if let inlineData = try? container.decode(InlineData.self, forKey: .inlineData) {
            self = .inlineData(inlineData)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid part"))
        }
    }
}

struct GeminiContent: Codable {
    let parts: [PartOrData]
}

struct GenerateContentRequest: Codable {
    let contents: [GeminiContent]
}

struct GenerateContentResponse: Codable {
    struct Candidate: Codable {
        struct Content: Codable {
            struct Part: Codable {
                let text: String?
            }
            let parts: [Part]
        }
        let content: Content
    }

    let candidates: [Candidate]
}
