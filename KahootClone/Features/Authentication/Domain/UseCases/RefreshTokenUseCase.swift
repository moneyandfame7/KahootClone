//
//  RefreshTokenUseCase.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 11.06.2024.
//

import Factory
import Foundation

struct RefreshTokenParams: Codable {
    let refreshToken: String
}

struct RefreshTokenResult: Codable {
    let accessToken: String
}

final class RefreshTokenUseCase: BaseUseCase {
    @Injected(\.httpClient) private var httpClient

    typealias Params = EmptyStruct?

    typealias Result = String

    func execute(params: Params = nil) async throws -> Result {
        let endpoint = Api.Auth.refreshToken
        let request: Request = endpoint.createRequest()

        let response: Result = try await httpClient.makeRequest(request)

        return response
    }
}
