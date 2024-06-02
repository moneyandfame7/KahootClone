//
//  RegisterUseCase.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Factory
import Foundation

struct AuthResult: Codable {
    let tokens: TokensEntity

    let user: UserEntity
}

struct RegisterParams: Codable {
    let username: String

    let email: String

    let password: String
}

final class RegisterUseCase: BaseUseCase {
    @Injected(\.httpClient) private var httpClient

    typealias Params = RegisterParams

    typealias Result = AuthResult

    func execute(params: Params) async throws -> Result {
        let endpoint = Api.Auth.register(params: params)
        let request: Request = endpoint.createRequest()

        let response: Result = try await httpClient.makeRequest(request)

        return response
    }
}
