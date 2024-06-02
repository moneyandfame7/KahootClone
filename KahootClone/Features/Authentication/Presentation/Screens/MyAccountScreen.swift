//
//  MyAccountScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import Factory
import SwiftUI

struct MyAccountScreen: View {
    @Injected(\.authenticationViewModel) private var authViewModel

    @Injected(\.router) private var router

    @Environment(\.detectedOS) private var detectedOS

    @ViewBuilder
    var unauthenticatedAccount: some View {
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
            AuthenticationButtons()
        }
        .padding(25)
        .background(.surfaceMain)
    }

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
                if !authViewModel.isAuth {
                    unauthenticatedAccount
                } else {
                    VStack {
                        VStack(spacing: 0) {
                            Text(authViewModel.user!.username)
                                .font(.custom("Montserrat", size: 18))
                                .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.textPrimary)
                            Text(authViewModel.user!.email)
                                .font(.custom("Montserrat", size: 12))
                                .foregroundStyle(.textSecondary)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
//                    .background(.red)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundMain)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MyAccountScreen()
}