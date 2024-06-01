//
//  Application.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import Factory
import SwiftUI

@main
struct Application: App {
    @Injected(\.appState) var appState

    @Injected(\.router) private var router

    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
            #endif
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
