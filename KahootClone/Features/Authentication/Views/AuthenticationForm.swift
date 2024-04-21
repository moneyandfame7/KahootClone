//
//  AuthenticationForm.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import SwiftUI

// в action передавати AuthInfo чи шось таке
struct AuthenticationForm: View {
    let variant: AuthenticationVariant

    @Binding var email: String
    @Binding var password: String

    @Binding var error: String

    var isLoading = false

    var action: () -> Void

    var body: some View {
        VStack {
            Text(variant.rawValue)
                .font(.custom("Montserrat", size: 24))
                .fontWeight(.bold)
                .foregroundStyle(.white)

            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(KCTextFieldStyle())
                #if os(iOS)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                #endif
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)

                SecureField("Password", text: $password)
                    .textFieldStyle(KCTextFieldStyle())
                if !error.isEmpty {
                    Text(error)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.redMain)
                        .padding(.top)
                }
                Spacer().frame(height: 50)

                ButtonPrimary(
                    title: variant.rawValue,
                    variant: .green,
                    fullWidth: true,
                    isLoading: isLoading,
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
    AuthenticationForm(
        variant: .signIn,
        email: .constant(""),
        password: .constant(""),
        error: .constant(""),
        isLoading: true
    ) {
        print("PIZDEC")
    }
}
