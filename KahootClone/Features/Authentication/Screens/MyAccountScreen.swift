//
//  MyAccountScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import SwiftUI

struct MyAccountScreen: View {
    @Environment(Router.self) private var router
    @Environment(\.detectedOS) private var detectedOS
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: router.navigateBack) {
                    Image(systemName: "arrow.backward")
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.plain)

                Spacer()
                Text("My Account")
                    .font(.custom("Montserrat", size: 14))
                    .fontWeight(.bold)
                Spacer()

                Button(action: {
                    router.navigate(to: .settings)
                }) {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)

            ScrollView {
                ConditionalStack(
                    horizontally: detectedOS == .macOS,
                    vSpacing: 15,
                    hSpacing: 15,
                    vAlignment: .bottom,
                    hAlignment: .leading
                ) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Sign in for more")
                            .font(.custom("Montserrat", size: 26))
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)

                        Text("Create and save kahoots, and access more features with a Kahoot! account.")
                            .font(.custom("Montserrat", size: 16))
                            .fontWeight(.medium)
                            .foregroundStyle(.textSecondary)
                    }
                    HStack(spacing: 25) {
                        ButtonPrimary(title: "Sign in", variant: .background, fullWidth: true) {
                            router.navigate(to: .authentication(variant: .signIn))
                        }

                        ButtonPrimary(title: "Sign up", fullWidth: true) {
                            router.navigate(to: .authentication(variant: .signUp))
                        }
                    }
                }
                .padding(25)
                .background(.surfaceMain)
                VStack {}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundMain)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MyAccountScreen()
        .environment(Router.shared)
}
