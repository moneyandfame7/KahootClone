//
//  AppState.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 06.04.2024.
//

import Factory
import Observation
import SwiftUI

@Observable
final class AppState {
   
    init() {}
}

extension AppState {
    static let shared = AppState()
}

extension Container {
    var appState: Factory<AppState> {
        self { AppState() }
            .singleton
    }
}
