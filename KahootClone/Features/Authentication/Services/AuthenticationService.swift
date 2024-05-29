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

    func helloWorld() async throws -> NoResponse {
        let params = ["username": "12345678", "password": "password"]

        let resource = Request<NoResponse>(
            url: "http://localhost:3000/hello-world",
            method: .post(params)
        )
        let response = try await httpClient.makeRequest(resource)

        return response
    }
}
