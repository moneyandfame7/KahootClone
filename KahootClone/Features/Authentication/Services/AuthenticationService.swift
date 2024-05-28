//
//  AuthenticationService.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import Factory
import FirebaseAuth
import Foundation

struct AuthenticationUser {
    let uid: String
    let email: String?
    let photoURL: String?

    init(user: User) {
        uid = user.uid
        email = user.email
        photoURL = user.photoURL?.absoluteString
    }
}

extension AuthErrorCode.Code {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}

final class AuthenticationService {
    init() {}

    func getAuthenticatedUser() -> AuthenticationUser? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }

        return AuthenticationUser(user: user)
    }

    func signUp(email: String, password: String) async throws -> AuthenticationUser {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)

        return AuthenticationUser(user: result.user)
    }

    func signIn(withEmail: String, password: String) async throws -> AuthenticationUser {
        let result = try await Auth.auth().signIn(withEmail: withEmail, password: password)

        return AuthenticationUser(user: result.user)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}

extension AuthenticationService {
    static let shared = AuthenticationService()
}

// Factory DI

extension Container {
    var authenticationService: Factory<AuthenticationService> {
        self { AuthenticationService() }
            .singleton
    }
}
