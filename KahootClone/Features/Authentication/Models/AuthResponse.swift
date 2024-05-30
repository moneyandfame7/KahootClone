//
//  AuthResponse.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 30.05.2024.
//

import Foundation

struct AuthResponse: Codable {
    let tokens: Tokens
    let user: User
}
