//
//  SignUpScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import SwiftUI

struct SignUpScreen: View {
    @Injected(\.router) private var router

    @Environment(AuthenticationViewModel.self) private var vm
    var body: some View {
        @Bindable var vm = vm

        VStack {
            AuthenticationForm(
                variant: .signUp,
                email: $vm.email,
                password: $vm.password,
                error: $vm.error,
                isLoading: vm.isLoading
            ) {
                vm.signUp {
                    router.navigateToRoot()
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
        .environment(AuthenticationViewModel(variant: .signUp))
}
