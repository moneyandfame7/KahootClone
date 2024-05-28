//
//  SettingsViewModel.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 06.04.2024.
//

import Factory
import OSLog
import SwiftUI

@Observable
final class SettingsViewModel {
    @ObservationIgnored
    @Injected(\.authenticationService) var authenticationService

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: SettingsViewModel.self)
    )

    var isAuthenticated = false {
        didSet {
            print("WAS CHANGED!!!", isAuthenticated)
        }
    }

    func signOut() {
        do {
            try authenticationService.signOut()
            isAuthenticated = false
        } catch {
            Self.logger.error("Sign Out: \(error.localizedDescription)")
        }
    }
}

// Factory Dependency Injection
extension Container {
    var settingsViewModel: Factory<SettingsViewModel> {
        self { SettingsViewModel() }
            .singleton
    }
}
