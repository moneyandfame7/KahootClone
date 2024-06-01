//
//  AppState.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 31.05.2024.
//

import Foundation
import SwiftUI

@Observable
final class AppState {
    var currentUser: User?
    var tokens: Tokens?

    private let userDefaults = UserDefaults.standard

    init() {
        loadCredentials()
    }

    var isAuth: Bool {
        guard let tokens else { return false }
        if currentUser == nil { return false }

        return !tokens.accessToken.isEmpty && !tokens.refreshToken.isEmpty
    }

    private func loadCredentials() {
        let accessToken = userDefaults.string(forKey: "accessToken") ?? ""
        let refreshToken = userDefaults.string(forKey: "refreshToken") ?? ""

        tokens = Tokens(accessToken: accessToken, refreshToken: refreshToken)
        if let userData = userDefaults.data(forKey: "user") {
            currentUser = try? JSONDecoder().decode(User.self, from: userData)
        }
    }

    func persistCredentials(tokens: Tokens, user: User) {
        self.tokens = tokens
        currentUser = user

        userDefaults.set(tokens.accessToken, forKey: "accessToken")
        userDefaults.set(tokens.refreshToken, forKey: "refreshToken")
        userDefaults.set(try? JSONEncoder().encode(user), forKey: "user")
    }
}
