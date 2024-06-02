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
            isAuthenticated = false
        } catch {
            Self.logger.error("Sign Out: \(error.localizedDescription)")
        }
    }
}
