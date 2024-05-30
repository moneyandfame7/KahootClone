//
//  SignInScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import SwiftUI

struct SignInScreen: View {
    @Injected(\.router) private var router

    @Environment(AuthenticationViewModel.self) private var vm

    var body: some View {
        @Bindable var vm = vm

        AuthenticationForm(
            variant: .signIn,
            email: $vm.email,
            password: $vm.password,
            error: $vm.error,
            isLoading: vm.isLoading
        ) {
            vm.signIn {
                router.navigateToRoot()
            }
        }
    }
}

#Preview {
    SignInScreen()
        .environment(AuthenticationViewModel(variant: .signIn))
}
