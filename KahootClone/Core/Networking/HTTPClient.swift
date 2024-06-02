//
//  HTTPClient.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 28.05.2024.
//

import Foundation

final class HTTPClient {
    let baseUrl: String

    private let session: URLSession

    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(baseUrl: String) {
        self.baseUrl = baseUrl
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]

//        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
//
//        if let accessToken {
//            configuration.httpAdditionalHeaders?["Authorization"] = "Bearer \(accessToken)"
//        }

        session = URLSession(configuration: configuration)
        decoder = JSONDecoder()
        encoder = JSONEncoder()
    }

    func makeRequest<Response: Codable>(_ request: Request, useRefreshToken: Bool = false) async throws -> Response {
        let urlRequest = try prepareUrlRequest(for: request, useRefreshToken: useRefreshToken)

        let (data, response) = try await session.data(for: urlRequest)

        try validate(data: data, response: response)

        if data.isEmpty {
            if Response.self == NoResponse.self {
                return NoResponse() as! Response
            }

            throw NetworkError.customError("Data was unexpectedly empty")
        }

        return try decode(data)
    }

    private func prepareUrlRequest(for request: Request, useRefreshToken: Bool) throws -> URLRequest {
        let fullUrlString = URL(string: baseUrl + request.path)!

        var urlRequest = URLRequest(url: fullUrlString)

        switch request.method {
        case let .get(queryItems):
            var components = URLComponents(url: fullUrlString, resolvingAgainstBaseURL: false)
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

        let jwtToken = UserDefaults.standard.string(forKey: useRefreshToken ? "refreshToken" : "accessToken")

        if let jwtToken {
            urlRequest.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            print(jwtToken, "<<< JWT")
        } else {
            print("NO JWT TOKEN SUKA :)")
        }
        return urlRequest
    }

    private func validate(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
//        print(httpResponse.statusCode, "<<< STATUS_CODE")
//        if httpResponse.statusCode == 401 {
//            throw NetworkError.unauthorized
//        }

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
            print(String(describing: error))
            throw NetworkError.decodingError(error)
        }
    }
}
