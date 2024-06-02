//
//  Api.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 30.05.2024.
//

import Foundation

protocol ApiModule {
    func createRequest() -> Request
}

enum Api {
    enum Common: ApiModule {
        case helloWorld(username: String, password: String)
    }

    enum Auth: ApiModule {
        case register(params: RegisterParams)

        case login(params: LoginParams)

        case test

        case protectedRoute
    }
}

extension Api.Common {
    func createRequest() -> Request {
        switch self {
        case let .helloWorld(username, password):
            return Request(path: "/hello-world", method: .post(["username": username, "password": password]))
        }
    }
}

extension Api.Auth {
    func createRequest() -> Request {
        switch self {
        case let .register(params):
            return Request(
                path: "/auth/register",
                method: .post(params)
            )

        case let .login(params):
            return Request(
                path: "/auth/login",
                method: .post(params)
            )

        case .test:
            return Request(path: "/auth/test", method: .get())

        case .protectedRoute:
            return Request(path: "/auth/protected", method: .get())
        }
    }
}
