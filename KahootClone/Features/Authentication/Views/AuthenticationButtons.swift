//
//  AuthenticationButtons.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.05.2024.
//

import SwiftUI

struct AuthenticationButtons: View {
    var size: ButtonSize = .small
    @Environment(Router.self) private var router

    var body: some View {
        HStack(spacing: size == .small ? 10 : 25) {
            ButtonPrimary(title: "Sign in", size: size, variant: .background, fullWidth: true) {
                router.navigate(to: .authentication(variant: .signIn))
            }

            ButtonPrimary(title: "Sign up", size: size, fullWidth: true) {
                router.navigate(to: .authentication(variant: .signUp))
            }
        }
    }
}

#Preview {
    VStack {
        AuthenticationButtons()
            .environment(Router.shared)
    }
    .frame(width: 250, height: 100)
}
