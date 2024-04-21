//
//  Application.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import FirebaseCore
import SwiftUI

@main
struct Application: App {
    @State private var router = Router()
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
            #endif
        }
        .environment(router)
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
