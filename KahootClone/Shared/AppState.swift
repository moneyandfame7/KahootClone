//
//  AppState.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 06.04.2024.
//

import Foundation

@Observable
final class AppState {
    var isAuthenticated = false

    private init() {
        let user = AuthenticationService.shared.getAuthenticatedUser()

        isAuthenticated = user != nil
    }
}
