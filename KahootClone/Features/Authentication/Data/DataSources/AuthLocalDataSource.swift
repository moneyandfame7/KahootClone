//
//  AuthLocalDataSource.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Foundation

protocol AuthLocalDataSourceProtocol {
    func setCredentials(user: UserEntity, tokens: TokensEntity) -> Void

    func getCredentials() -> AuthResult?

    func clearCredentials() -> Void
}

final class AuthLocalDataSource: AuthLocalDataSourceProtocol {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard

    func getCredentials() -> AuthResult? {
        var tokens: TokensEntity?
        var user: UserEntity?

        do {
            if let tokenData = userDefaults.data(forKey: "jwtTokens") {
                tokens = try decoder.decode(TokensEntity.self, from: tokenData)
            }

            if let userData = userDefaults.data(forKey: "user") {
                user = try decoder.decode(UserEntity.self, from: userData)
            }

            if let user, let tokens {
                return AuthResult(tokens: tokens, user: user)
            }

            print("User or tokens not founded in UserDefaults")

            return nil
        } catch {
            print(String(describing: error))

            return nil
        }
    }

    func setCredentials(user: UserEntity, tokens: TokensEntity) {
        do {
            try userDefaults.set(encoder.encode(tokens), forKey: "jwtTokens")
            try userDefaults.set(encoder.encode(user), forKey: "user")
        } catch {
            print(String(describing: error))
        }
    }

    func clearCredentials() {}
}
