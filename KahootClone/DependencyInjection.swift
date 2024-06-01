//
//  DependencyContainer.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Factory
import Foundation

// MARK: AppState

extension Container {
    var appState: Factory<AppState> {
        self { AppState() }.singleton
    }
}

// MARK: Internal

extension Container {
    var httpClient: Factory<HTTPClient> {
        self { HTTPClient(baseUrl: "http://localhost:3000") }.singleton
    }

    var router: Factory<Router> {
        self { Router() }.singleton
    }
}

// MARK: Services

extension Container {
    var authenticationService: Factory<AuthenticationService> {
        self { AuthenticationService() }.singleton
    }
}

// MARK: ViewModels

extension Container {
    var settingsViewModel: Factory<SettingsViewModel> {
        self { SettingsViewModel() }.singleton
    }
}
