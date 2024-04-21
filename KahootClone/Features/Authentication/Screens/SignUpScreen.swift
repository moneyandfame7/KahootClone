//
//  SignUpScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import SwiftUI

enum SignUpStage {
    case username, form
}

struct SignUpScreen: View {
    @Environment(Router.self) private var router

    @Environment(AuthenticationViewModel.self) private var vm
    var body: some View {
        @Bindable var vm = vm

        VStack {
            ZStack {
                switch vm.signUpStage {
                case .username:
                    CreateUsernameView()
                        .compositingGroup()
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .form:
                    VStack(spacing: 25) {
                        Button(action: {
                            withAnimation {
                                vm.signUpStage = .username
                            }
                        }) {
                            Image(systemName: "arrow.backward")
                                .foregroundStyle(.textSecondary)
                                .imageScale(.large)
                                .fontWeight(.bold)
                        }

                        AuthenticationForm(
                            variant: .signUp,
                            email: $vm.email,
                            password: $vm.password,
                            error: $vm.error
                        ) {
                            vm.signUp {
                                router.navigateToRoot()
                            }
                        }
                    }
                    .compositingGroup()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.violetMain)
        .foregroundStyle(.white)
    }
}

#Preview {
    SignUpScreen()
        .environment(Router.shared)
        .environment(AuthenticationViewModel(variant: .signUp))
}
