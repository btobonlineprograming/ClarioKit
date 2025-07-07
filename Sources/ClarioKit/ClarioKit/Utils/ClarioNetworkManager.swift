//
//  ClarioNetworkManager.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/7/25.
//

import Foundation


final class ClarioNetworkManager {
    
    static let shared = ClarioNetworkManager()
    private init() {}

    @available(iOS 13.0, *)
    func get<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response): (Data, URLResponse)
            
            if #available(iOS 15.0, *) {
                (data, response) = try await URLSession.shared.data(for: request)
            } else {
                (data, response) = try await legacyData(for: request)
            }

            try validate(response: response)
            return try decode(data: data)
        } catch {
            throw resolve(error)
        }
    }

    @available(iOS 13.0, *)
    func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(body)
            
            let (data, response): (Data, URLResponse)
            
            if #available(iOS 15.0, *) {
                (data, response) = try await URLSession.shared.data(for: request)
            } else {
                (data, response) = try await legacyData(for: request)
            }

            try validate(response: response)
            return try decode(data: data)
        } catch {
            throw resolve(error)
        }
    }

    // MARK: - Legacy Support

    @available(iOS 13.0, *)
    private func legacyData(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: ClarioNetworkError.unknown(NSError(domain: "Unknown error", code: 0)))
                }
            }.resume()
        }
    }

    // MARK: - Helpers

    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw ClarioNetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }

    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ClarioNetworkError.decodingFailed
        }
    }

    private func resolve(_ error: Error) -> ClarioNetworkError {
        return error as? ClarioNetworkError ?? .unknown(error)
    }
}
