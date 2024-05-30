//
//  AuthenticationService.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import Factory
import Foundation

protocol Authentication {
    func helloWorld() async throws -> NoResponse

    func helloHui() -> Void
}

final class AuthenticationService: Authentication {
    @Injected(\.httpClient) private var httpClient
    init() {}

    func helloWorld() async throws -> NoResponse {
        print("HELLO_WORLD <REAL>")
        let endpoint = Api.Common.helloWorld(username: "12345678", password: "password")
        let request: Request = endpoint.createRequest()

        let response: NoResponse = try await httpClient.makeRequest(request)

        return response
    }

    func helloHui() {
        print("<REAL> AUTH_HUI")
    }

    func login(username: String, password: String) async throws {
        let endpoint = Api.Auth.login(username: username, password: password)
        let request: Request = endpoint.createRequest()

        let response: AuthResponse = try await httpClient.makeRequest(request)
        
        print("ACCESS_TOKEN:", response.tokens.accessToken)
    }

    func signUp(email: String, username: String, password: String) async throws {
        let endpoint = Api.Auth.signup(email: email, username: username, password: password)
        let request: Request = endpoint.createRequest()

        let response: AuthResponse = try await httpClient.makeRequest(request)

        print("ACCESS_TOKEN:", response.tokens.accessToken)
    }
}

final class AuthenticationServiceMock: Authentication {
    func helloWorld() async throws -> NoResponse {
        print("HELLO_WORLD <MOCK>")
        return NoResponse()
    }

    func helloHui() {
        print("<MOCK> AUTH_HUI")
    }
}
