//
//  AuthenticationForm.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import Factory
import SwiftUI

struct AuthenticationFormValues {
    var username: String = ""

    var email: String = ""

    var password: String = ""

    var isLoading: Bool = false

    var error: String = ""

    func isValid(for variant: AuthenticationVariant) -> Bool {
        switch variant {
        case .login:
            return !username.isEmpty && !password.isEmpty
        case .register:
            return !username.isEmpty && !email.isEmpty && !password.isEmpty
        }
    }

    mutating func reset() {
        username = ""
        email = ""
        password = ""
        isLoading = false
        error = ""
    }
}

struct AuthenticationForm: View {
    @Injected(\.router) private var router

    @Injected(\.authenticationViewModel) private var authenticationViewModel

    @Binding var formValues: AuthenticationFormValues

    var variant: AuthenticationVariant

    private func handleRegister() {
        Task { @MainActor in
            do {
                let params = RegisterParams(
                    username: formValues.username,
                    email: formValues.email,
                    password: formValues.password
                )

                formValues.isLoading = true

                try await authenticationViewModel.register(params: params)

                formValues.isLoading = false

                router.navigateToRoot()

            } catch {
                formValues.error = error.localizedDescription
                print("AuthRegister: ", error.localizedDescription)
            }
        }
    }

    private func handleLogin() {
        Task { @MainActor in
            do {
                let params = LoginParams(
                    username: formValues.username,
                    password: formValues.password
                )
                formValues.isLoading = true
                try await authenticationViewModel.login(params: params)

                formValues.isLoading = false
                router.navigateToRoot()
            } catch {
                formValues.error = error.localizedDescription
                print("AuthSignIn: ", error.localizedDescription)
            }
        }
    }

    var body: some View {
        VStack {
            Text(variant.rawValue)
                .font(.custom("Montserrat", size: 24))
                .fontWeight(.bold)
                .foregroundStyle(.white)

            VStack {
                if variant == .register {
                    TextField("Username", text: $formValues.username)
                        .textFieldStyle(KCTextFieldStyle())
                }
                TextField("Email", text: $formValues.email)
                    .textFieldStyle(KCTextFieldStyle())
                #if os(iOS)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                #endif
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)

                SecureField("Password", text: $formValues.password)
                    .textFieldStyle(KCTextFieldStyle())
                if !formValues.error.isEmpty {
                    Text(formValues.error)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.redMain)
                        .padding(.top)
                }
                Spacer().frame(height: 50)

                ButtonPrimary(
                    title: variant.rawValue,
                    variant: .green,
                    fullWidth: true,
                    disabled: true,
                    action: variant == .login ? handleLogin : handleRegister
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
    AuthenticationForm(formValues: .constant(AuthenticationFormValues()), variant: .login)
}
