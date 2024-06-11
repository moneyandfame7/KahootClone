//
//  AuthenticationViewModel.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import Observation
import SwiftUI

enum AuthenticationVariant: String {
    case login = "Log in"
    case register = "Register"
}

@Observable
final class AuthenticationViewModel {
    @ObservationIgnored
    @Injected(\.registerUseCase) private var registerUseCase
    @ObservationIgnored
    @Injected(\.loginUseCase) private var loginUseCase

    var user: UserEntity?

    var tokens: TokensEntity?

    var counter = 0

    var isAuth: Bool {
        guard let tokens else { return false }
        if user == nil { return false }

        return !tokens.accessToken.isEmpty && !tokens.refreshToken.isEmpty
    }

    init() {
        print("INIT AUTH_VIEW_MODEL")
    }

    func protectedRoute() {
        Task { @MainActor in }
    }

    func signIn(completion: @escaping () -> Void) {
        Task { @MainActor in }
    }

    func register(params: RegisterParams) async throws {
        let result = try await registerUseCase.execute(params: params)

        user = result.user
        tokens = result.tokens
    }

    func login(params: LoginParams) async throws {
        let result = try await loginUseCase.execute(params: params)

        user = result.user
        tokens = result.tokens
    }

    func restoreSession() {
        print("RESTORE SESSION")
    }
}
