//
//  DependencyContainer.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Factory
import Foundation

// MARK: Internal

extension Container {
    var httpClient: Factory<HTTPClient> {
        self { HTTPClient(baseUrl: "http://localhost:3000") }.singleton
    }

    var router: Factory<Router> {
        self { Router() }.singleton
    }
}

// MARK: UseCases

extension Container {
    var registerUseCase: Factory<RegisterUseCase> {
        self { RegisterUseCase() }
    }

    var loginUseCase: Factory<LoginUseCase> {
        self { LoginUseCase() }
    }

    var protectedUseCase: Factory<ProtectedUseCase> {
        self { ProtectedUseCase() }
    }
}

// MARK: DataSources

extension Container {
    var authRemoteDataSource: Factory<AuthRemoteDataSourceProtocol> {
        self { AuthRemoteDataSource() }
    }

    var authLocalDataSource: Factory<AuthLocalDataSourceProtocol> {
        self { AuthLocalDataSource() }
    }
}

// MARK: ViewModels

extension Container {
    var authenticationViewModel: Factory<AuthenticationViewModel> {
        self { AuthenticationViewModel() }.singleton
    }

    var settingsViewModel: Factory<SettingsViewModel> {
        self { SettingsViewModel() }.singleton
    }
}
