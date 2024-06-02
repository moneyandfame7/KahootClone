//
//  HTTPMethod.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Foundation

enum HTTPMethod {
    case get([URLQueryItem] = [])
    case post(Encodable? = nil)
    case delete

    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
