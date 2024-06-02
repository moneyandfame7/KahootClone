//
//  AuthRemoteDataSource.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Factory
import Foundation

protocol AuthRemoteDataSourceProtocol {
    func register(params: RegisterParams) async throws -> AuthResult

    func login(params: LoginParams) async throws -> AuthResult

    func protected() -> Void
}

final class AuthRemoteDataSource: AuthRemoteDataSourceProtocol {
    @Injected(\.httpClient) private var httpClient

    func register(params: RegisterParams) async throws -> AuthResult {
        let endpoint = Api.Auth.register(params: params)
        let request = endpoint.createRequest()

        return try await httpClient.makeRequest(request)
    }

    func login(params: LoginParams) async throws -> AuthResult {
        let endpoint = Api.Auth.login(params: params)
        let request = endpoint.createRequest()

        return try await httpClient.makeRequest(request)
    }

    func protected() {
        print("Call /auth/protected")
    }
}
