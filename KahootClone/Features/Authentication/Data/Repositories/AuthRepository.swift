//
//  AuthRepository.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Factory
import Foundation

final class AuthRepository: AuthRepositoryProtocol {
    @Injected(\.authRemoteDataSource) private var remoteDataSource
    @Injected(\.authLocalDataSource) private var localDataSource

    func register(params: RegisterParams) async throws -> AuthResult {
        let result = try await remoteDataSource.register(params: params)

        localDataSource.setCredentials(user: result.user, tokens: result.tokens)

        return result
    }

    func login(params: LoginParams) async throws -> AuthResult {
        let result = try await remoteDataSource.login(params: params)

        localDataSource.setCredentials(user: result.user, tokens: result.tokens)

        return result
    }

    func protected() async throws {
        remoteDataSource.protected()
    }
}
