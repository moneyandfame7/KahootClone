//
//  AuthenticationForm.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import SwiftUI

// в action передавати AuthInfo чи шось таке
struct AuthenticationForm: View {
    @Injected(\.router) private var router

    @Bindable var vm: AuthenticationViewModel

    private func action() {
        if vm.variant == .signIn {
            vm.signIn {
                router.navigateToRoot()
            }
        } else {
            vm.signUp {
                router.navigateToRoot()
            }
        }
    }

    var body: some View {
        VStack {
            Text(vm.variant.rawValue)
                .font(.custom("Montserrat", size: 24))
                .fontWeight(.bold)
                .foregroundStyle(.white)

            VStack {
                if vm.variant == .signUp {
                    TextField("Username", text: $vm.username)
                        .textFieldStyle(KCTextFieldStyle())
                }
                TextField("Email", text: $vm.email)
                    .textFieldStyle(KCTextFieldStyle())
                #if os(iOS)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                #endif
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)

                SecureField("Password", text: $vm.password)
                    .textFieldStyle(KCTextFieldStyle())
                if !vm.error.isEmpty {
                    Text(vm.error)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.redMain)
                        .padding(.top)
                }
                Spacer().frame(height: 50)

                ButtonPrimary(
                    title: vm.variant.rawValue,
                    variant: .green,
                    fullWidth: true,
                    isLoading: vm.isLoading,
                    action: action
                )
                Divider()
                    .padding(.vertical, 35)
            }
            .padding()
            .background(.surfaceMain, in: .rect(cornerRadius: 8))
            .frame(maxWidth: 350)
        }
    }
}

#Preview("macOS") {
    AuthenticationForm(vm:
        AuthenticationViewModel(variant: .signIn))
}
