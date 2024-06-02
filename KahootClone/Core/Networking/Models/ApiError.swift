//
//  ApiError.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Foundation

enum ApiError: Error {
    case unauthorized

    case invalidUsername, invalidEmail, invalidPassword
}
