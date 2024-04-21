//
//  AuthenticationViewModel.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import SwiftUI

enum AuthenticationVariant: String {
    case signIn = "Sign in"
    case signUp = "Sign up"
}

@Observable final class AuthenticationViewModel {
    var variant: AuthenticationVariant

    var signUpStage: SignUpStage = .username

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
                let user = try await AuthenticationService.shared.signIn(withEmail: email, password: password)
                
                isLoading = false
                print("User: ", user)
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
                let user = try await AuthenticationService.shared.signUp(email: email, password: password)

                isLoading = false
                print("User: ", user)

                completion()
            } catch {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }
}
