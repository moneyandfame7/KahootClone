//
//  AuthenticationScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import SwiftUI

struct AuthenticationScreen: View {
    @Injected(\.router) private var router

    @State private var vm: AuthenticationViewModel

    init(variant: AuthenticationVariant) {
        _vm = State(initialValue: AuthenticationViewModel(variant: variant))
    }

    @ViewBuilder
    private var formView: some View {
        AuthenticationForm(vm: vm)
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
                Button("Test") {
                    print("PROTECTED TEST")
                    vm.protectedRoute()
                }
                Spacer()
                ButtonPrimary(title: vm.variant == .signIn ? "Sign up" : "Sign in", variant: .surface) {
                    vm.reset()
                    withAnimation {
                        vm.variant = vm.variant == .signIn ? .signUp : .signIn
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.violetDark, ignoresSafeAreaEdges: .all)

            ScrollView {
                formView
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
}
