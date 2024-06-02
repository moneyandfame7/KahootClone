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

    @State private var formValues: AuthenticationFormValues = .init()

    @State private var variant: AuthenticationVariant

    init(variant: AuthenticationVariant) {
        _variant = State(initialValue: variant)
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
                ButtonPrimary(title: variant == .login ? "Register" : "Login", variant: .surface) {
                    formValues.reset()
                    withAnimation {
                        variant = variant == .login ? .register : .login
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.violetDark, ignoresSafeAreaEdges: .all)

            ScrollView {
                AuthenticationForm(formValues: $formValues, variant: variant)
            }
            .safeAreaPadding(.vertical, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.violetMain)
        .font(.custom("Montserrat", size: 16))
        .foregroundStyle(.white)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AuthenticationScreen(variant: .login)
}
