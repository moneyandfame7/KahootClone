//
//  LoginUseCase.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Foundation
import Factory

struct LoginParams: Codable {
    let username: String
    
    let password: String
}

final class LoginUseCase: BaseUseCase {
    @Injected(\.httpClient) private var httpClient

    typealias Params = LoginParams

    typealias Result = AuthResult

    func execute(params: Params) async throws -> Result {
        let endpoint = Api.Auth.login(params: params)
        let request: Request = endpoint.createRequest()

        let response: Result = try await httpClient.makeRequest(request)

        return response
    }
}
