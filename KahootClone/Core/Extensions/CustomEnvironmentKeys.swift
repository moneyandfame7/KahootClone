//
//  CustomEnvironmentKeys.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import SwiftUI

enum OS {
    case macOS, iOS
}

private struct DetectedOSKey: EnvironmentKey {
    static let defaultValue: OS = {
        #if os(macOS)
            return .macOS
        #else
            return .iOS
        #endif
    }()
}

extension EnvironmentValues {
    var detectedOS: OS {
        get { self[DetectedOSKey.self] }
        set { self[DetectedOSKey.self] = newValue }
    }
}
