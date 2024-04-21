//
//  HomeHeaderView.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

#if os(iOS)
    import SwiftUI

    struct HomeHeaderView: View {
        @Environment(Router.self) private var router
        @Environment(\.colorScheme) var colorScheme

        var body: some View {
            HStack {
                Button(action: {
                    router.navigate(to: .myAccount)
                }) {
                    Image(systemName: "person.circle.fill")
                        .imageScale(.large)
                    #if os(macOS)
                        .fontWeight(.bold)
                    #else
                        .fontWeight(.medium)
                    #endif
                        .foregroundStyle(.textSecondary)
                }

                Spacer()
                Image(colorScheme == .dark ? .logoWhite : .logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                Spacer()

                Button(action: {}) {
                    Image(systemName: "bell")
                        .imageScale(.large)
                    #if os(macOS)
                        .fontWeight(.bold)
                    #else
                        .fontWeight(.medium)
                    #endif
                        .foregroundStyle(.textSecondary)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .padding(.horizontal, 15)
            .background(.surfaceMain, ignoresSafeAreaEdges: .all)
            .compositingGroup()
            .shadow(radius: 3, y: 2)
        }
    }

    #Preview {
        HomeHeaderView()
            .environment(Router.shared)
    }
#endif
