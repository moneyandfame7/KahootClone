//
//  NetworkError.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError(Error)
    case invalidResponse
    case invalidURL
    case httpError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Unable to perform request", comment: "badRequestError")
        case let .serverError(errorMessage):
            return NSLocalizedString(errorMessage, comment: "serverError")
        case .decodingError:
            return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
        case .invalidResponse:
            return NSLocalizedString("Invalid response", comment: "invalidResponse")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "invalidURL")
        case .httpError:
            return NSLocalizedString("Bad request", comment: "badRequest")
        }
    }
}
