//
//  ProtectedUseCase.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 11.06.2024.
//

import Foundation
import Factory

final class ProtectedUseCase: BaseUseCase {
    @Injected(\.httpClient) private var httpClient

    typealias Params = EmptyStruct?

    typealias Result = EmptyStruct

    func execute(params: Params = nil) async throws -> Result {
        let endpoint = Api.Auth.protectedRoute
        let request: Request = endpoint.createRequest()

        let response: Result = try await httpClient.makeRequest(request)

        return response
    }
}
