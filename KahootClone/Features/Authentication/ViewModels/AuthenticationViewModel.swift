//
//  AuthenticationViewModel.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import SwiftUI

enum AuthenticationVariant: String {
    case signIn = "Sign in"
    case signUp = "Sign up"
}

// TODO: переробити якось це, тут тримати готово юзера, а не username, email, password і т.д
@Observable final class AuthenticationViewModel {
    @ObservationIgnored
    @Injected(\.appState) var appState

    @ObservationIgnored
    @Injected(\.authenticationService) var authenticationService

    var variant: AuthenticationVariant

    var username = ""
    var email = ""
    var password = ""
    var error = ""
    var isLoading = false

    init(variant: AuthenticationVariant) {
        self.variant = variant
    }

    func protectedRoute() {
        Task { @MainActor in
            do {
                try await authenticationService.protectedRoute()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func signIn(completion: @escaping () -> Void) {
        Task { @MainActor in
            do {
                error = ""
                isLoading = true
//                let user = try await authenticationService.signIn(withEmail: email, password: password)

                isLoading = false

                completion()
            } catch {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }

    func signUp(completion: @escaping () -> Void) {
        Task { @MainActor in
            do {
                error = ""
                isLoading = true

                let result = try await authenticationService.signUp(
                    email: email,
                    username: username,
                    password: password
                )

                print("AUTH_RESPONSE: ", result)

                appState.persistCredentials(tokens: result.tokens, user: result.user)

                isLoading = false

                completion()
            } catch {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }

    func reset() {
        email = ""
        password = ""
        error = ""
    }
}
