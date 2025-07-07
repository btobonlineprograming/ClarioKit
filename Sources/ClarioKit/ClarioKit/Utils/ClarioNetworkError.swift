//
//  ClarioNetworkError.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/7/25.
//

enum ClarioNetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed
    case unknown(Error)
}
