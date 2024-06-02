//
//  UserEntity.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Foundation

struct UserEntity: Identifiable, Codable {
    let id: String

    let username: String

    let email: String

    let password: String
}
