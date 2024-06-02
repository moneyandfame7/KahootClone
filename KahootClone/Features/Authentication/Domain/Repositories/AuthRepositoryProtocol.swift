//
//  AuthRepositoryProtocol.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(params: LoginParams) async throws -> AuthResult

    func register(params: RegisterParams) async throws -> AuthResult

    func protected() async throws -> Void
}
