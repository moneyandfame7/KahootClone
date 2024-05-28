//
//  JoinView.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 22.05.2024.
//

import SwiftUI

private enum Field: Int, Hashable {
    case pin
}

struct JoinView: View {
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?

    @State private var pin = ""
    @State private var isHelpPresented = false

    var body: some View {
        VStack {
            HStack {
                ButtonIcon(icon: "xmark") {
                    dismiss()
                }
                Spacer()
                Text("Join game")
                    .font(.custom("Montserrat", size: 16))
                    .fontWeight(.bold)
                Spacer()
                ButtonPrimary(icon: "questionmark", variant: .surface) {
                    isHelpPresented = true
                }
            }

            Spacer()
            ZStack(alignment: .center) {
                if pin.isEmpty {
                    Text("PIN")
                        .font(.custom("Montserrat", size: 48))
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .animation(nil)
                        .transition(.identity)
                }
                TextField("", text: $pin.animation(.bouncy))
                    .textFieldStyle(.plain)
                    .font(.custom("Montserrat", size: 48))
                    .tint(.white)
                    .accentColor(.white)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .focused($focusedField, equals: .pin)
                    .task {
                        focusedField = .pin
                    }
                #if os(iOS)
                    .keyboardType(.numberPad)
                #endif
            }
//            .frame(height: 250)
//            .border(.red)
            Spacer()
            VStack {
                if !pin.isEmpty {
                    ButtonPrimary(title: "Enter", icon: "arrow.right", variant: .primary, fullWidth: true) {}
                        .transition(.opacity.combined(with: .scale(0.95)))
                }
            }
            .frame(height: 60)
        }
        .padding()
        #if os(macOS)
            .frame(width: 500, height: 500)
        #else
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        #endif
            .background(.violetDark)
            .foregroundStyle(.white)
            .sheet(isPresented: $isHelpPresented) {
                VStack {
                    HStack {
                        ButtonIcon(icon: "xmark") {
                            isHelpPresented = false
                        }
                        .shadow(radius: 2, y: 1)
                        Spacer()
                        Text("Help")
                            .font(.custom("Montserrat", size: 16))
                            .fontWeight(.bold)
                        Spacer()
                    }

                    Spacer()
                    VStack(spacing: 40) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Where to find the game PIN?")
                                .font(.custom("Montserrat", size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.textPrimary)

                            Text(
                                "The PIN is generated and needs to be made accessible by the **host** of the game. In a live game mode, players can see it at the top of host's screen."
                            )
                            .font(.custom("Montserrat", size: 14))
                            .foregroundStyle(.textSecondary)
                        }

                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: Tab.discover.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.textPrimary)
                                .fontWeight(.bold)
                            VStack(alignment: .leading) {
                                Text("Don't have a game to join?")
                                    .font(.custom("Montserrat", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.textPrimary)
                                Text("Pick a game from the Discover page and play on your own.")
                                    .font(.custom("Montserrat", size: 12))
                                    .foregroundStyle(.textSecondary)
                                    .fontWeight(.medium)
                            }

                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.surfaceMain, in: .rect(cornerRadius: 6))
                        .compositingGroup()
                        .shadow(radius: 2, y: 1)

                        .onTapGesture {
                            isHelpPresented = false
                            dismiss()
                            router.selectTab(.discover)
                        }
                    }
                    Spacer()
                }
                .padding()
                #if os(macOS)
                    .frame(width: 450, height: 400)
                #else
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                #endif
            }
    }
}

#Preview {
    JoinView()
        .environment(Router.shared)
}
