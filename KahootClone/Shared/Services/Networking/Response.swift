//
//  Response.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Foundation

struct NoResponse: Codable {}

struct BadResponse: Error, Codable {
    let statusCode: Int
    let message: String
    let error: String
}
