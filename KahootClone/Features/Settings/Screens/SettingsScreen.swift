//
//  SettingsScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(Router.self) private var router

    @State private var vm = SettingsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    router.navigateBack()
                }) {
                    Image(systemName: "arrow.backward")
                        .imageScale(.large)
                        .foregroundStyle(.textPrimary)
                }
                .buttonStyle(.plain)

                Spacer()
                Text("Settings")
                    .font(.custom("Montserrat", size: 28))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)

            Form {
                VStack(alignment: .center) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.violetMain)
                    Text("username")
                        .font(.custom("Montserrat", size: 22))
                        .fontWeight(.medium)
                    Text("email@gmail.com")
                        .font(.custom("Montserrat", size: 14))
                }
                .padding()
                .frame(maxWidth: .infinity)

                Section {
                    Button(action: {
                        vm.signOut()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign out")
                        }
                        .font(.custom("Montserrat", size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.redMain)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.backgroundMain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsScreen()
        .environment(Router.shared)
}
