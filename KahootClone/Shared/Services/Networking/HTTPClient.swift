//
//  HTTPClient.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 28.05.2024.
//

import Foundation

final class HTTPClient {
    private let session: URLSession

    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]

        session = URLSession(configuration: configuration)
        decoder = JSONDecoder()
        encoder = JSONEncoder()
    }

    func makeRequest<T: Codable>(_ request: Request<T>) async throws -> T {
        let urlRequest = try prepareUrlRequest(for: request)

        let (data, response) = try await session.data(for: urlRequest)

        try validate(data: data, response: response)

        return try decode(data)
    }

    private func prepareUrlRequest<T>(for request: Request<T>) throws -> URLRequest {
        var urlRequest = URLRequest(url: request.url)

        switch request.method {
        case let .get(queryItems):
            var components = URLComponents(url: request.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badRequest
            }

            urlRequest = URLRequest(url: url)

        case let .post(body):
            urlRequest.httpMethod = request.method.name
            if let body {
                urlRequest.httpBody = try encoder.encode(body)
            }

        case .delete:
            urlRequest.httpMethod = request.method.name
        }
//        urlRequest.setValue("Bearer " + "hui pizda zalupa token", forHTTPHeaderField: "Authorization")
        return urlRequest
    }

    private func validate(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200 ..< 300).contains(httpResponse.statusCode) else {
            guard let apiError = try? decoder.decode(BadResponse.self, from: data) else {
                throw NetworkError.httpError(httpResponse.statusCode)
            }

            throw NetworkError.serverError(apiError.message)
        }
    }

    private func decode<T: Codable>(_ data: Data) throws -> T {
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
