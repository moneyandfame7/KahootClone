//
//  AuthenticationService.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import Factory
import Foundation

final class AuthenticationService {
    @Injected(\.httpClient) private var httpClient
    init() {}

    func protectedRoute() async throws {
        print("PROTECTED HUI")
        let endpoint = Api.Auth.protectedRoute
        let request = endpoint.createRequest()

        let response: NoResponse = try await httpClient.makeRequest(request)

        print("RESULT_ROUTE: ", response)
    }

    func login(username: String, password: String) async throws {
        let endpoint = Api.Auth.login(username: username, password: password)
        let request: Request = endpoint.createRequest()

        let response: AuthResponse = try await httpClient.makeRequest(request)

        print("ACCESS_TOKEN:", response.tokens.accessToken)
    }

    func signUp(email: String, username: String, password: String) async throws -> AuthResponse {
        let endpoint = Api.Auth.signup(email: email, username: username, password: password)
        let request: Request = endpoint.createRequest()

        let response: AuthResponse = try await httpClient.makeRequest(request)

        return response
    }

    func test() async throws -> String {
        let endpoint = Api.Auth.test
        let request: Request = endpoint.createRequest()

        let response: String = try await httpClient.makeRequest(request)

        return response
    }
}
