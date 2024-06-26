//
//  AuthenticationScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import SwiftUI


struct AuthenticationScreen: View {
    @Environment(Router.self) private var router

    @State private var vm: AuthenticationViewModel

    @State private var variant: AuthenticationVariant

    init(variant: AuthenticationVariant) {
        _variant = State(initialValue: variant)
        _vm = State(initialValue: AuthenticationViewModel(variant: variant))
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    router.navigateBack()
                }) {
                    Text("Cancel")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                .buttonStyle(.plain)

                Spacer()
                ButtonPrimary(title: variant == .signIn ? "Sign up" : "Sign in", variant: .surface) {
                    withAnimation {
                        variant = variant == .signIn ? .signUp : .signIn
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.violetDark, ignoresSafeAreaEdges: .all)

            ScrollView {
                ZStack {
                    if variant == .signIn {
                        SignInScreen()
                            .transition(.opacity.combined(with: .scale(0.5)))
                    } else {
                        SignUpScreen()
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .safeAreaPadding(.vertical, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.violetMain)
        .font(.custom("Montserrat", size: 16))
        .foregroundStyle(.white)
        .navigationBarBackButtonHidden()
        .environment(vm)
    }
}

#Preview {
    AuthenticationScreen(variant: .signIn)
        .environment(Router.shared)
}
