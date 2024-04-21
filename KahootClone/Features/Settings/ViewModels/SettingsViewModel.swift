//
//  SettingsViewModel.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 06.04.2024.
//

import Foundation
import OSLog

@Observable
final class SettingsViewModel {
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: SettingsViewModel.self)
    )

    func signOut() {
        do {
            try AuthenticationService.shared.signOut()
        } catch {
            Self.logger.error("Sign Out: \(error.localizedDescription)")
        }
    }
}
