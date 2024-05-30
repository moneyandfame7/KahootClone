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
        case signup(email: String, username: String, password: String)

        case login(username: String, password: String)
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
        case let .signup(email, username, password):
            return Request(
                path: "/auth/signup",
                method: .post(["email": email, "username": username, "password": password])
            )

        case let .login(username, password):
            return Request(
                path: "/auth/login",
                method: .post(["username": username, "password": password])
            )
        }
    }
}