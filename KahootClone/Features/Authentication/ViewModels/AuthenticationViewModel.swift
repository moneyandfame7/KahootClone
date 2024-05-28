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
    @Injected(\.authenticationService) var authenticationService

    @ObservationIgnored
    @Injected(\.settingsViewModel) var settingsViewModel

    var variant: AuthenticationVariant

    var username = ""
    var email = ""
    var password = ""
    var error = ""
    var isLoading = false

    init(variant: AuthenticationVariant) {
        self.variant = variant
    }

    func signIn(completion: @escaping () -> Void) {
        Task { @MainActor in
            do {
                error = ""
                isLoading = true
                let user = try await authenticationService.signIn(withEmail: email, password: password)

                isLoading = false
                print("User: ", user)
                settingsViewModel.isAuthenticated = true
                
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
                let user = try await authenticationService.signUp(email: email, password: password)

                isLoading = false
                print("User: ", user)
                settingsViewModel.isAuthenticated = true

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
