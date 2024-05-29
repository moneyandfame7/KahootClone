//
//  NavigationBar.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import SwiftUI
import Factory

struct NavigationBar: View {
    @Injected(\.settingsViewModel) private var settingsViewModel
    
    @Environment(Router.self) private var router
    @Environment(\.colorScheme) var colorScheme

    #if os(iOS)
        @ViewBuilder
        var iOSBarView: some View {
            HStack {
                ForEach(Tab.allCases) { tab in
                    Spacer()
                    NavigationBarItem(tab: tab)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(.surfaceMain, ignoresSafeAreaEdges: .all)
            .compositingGroup()
            .shadow(radius: 3)
        }
    #endif

    #if os(macOS)
        @ViewBuilder
        var macOSBarView: some View {
            VStack(spacing: 35) {
                HStack {
                    Image(colorScheme == .dark ? .logoWhite : .logo)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(Tab.allCases) { tab in
                        NavigationBarItem(tab: tab)
                    }
                }
                .font(.custom("Montserrat", size: 14))
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
                .frame(maxWidth: .infinity)
                Spacer()

                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .imageScale(.large)
                        #if os(macOS)
                            .fontWeight(.semibold)
                        #else
                            .fontWeight(.medium)
                        #endif
                            .foregroundStyle(.textSecondary)
                        Text("Your profile")
                            .font(.custom("Montserrat", size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)
                        Image(systemName: "arrow.forward")
                        #if os(macOS)
                            .fontWeight(.semibold)
                        #else
                            .fontWeight(.medium)
                        #endif
                            .foregroundStyle(.textSecondary)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .contentShape(.rect)
                    .onTapGesture {
                        router.navigate(to: .myAccount)
                    }

                    if !settingsViewModel.isAuthenticated {
                        AuthenticationButtons(size: .small)
                    }
                }
            }

            .frame(width: 150)
            .frame(maxHeight: .infinity)
            .safeAreaPadding(.vertical, 20)
            .safeAreaPadding(.horizontal, 15)
            .background(.surfaceMain)
            .compositingGroup()
            .shadow(radius: 2, x: 0.5)

            // MARK: важливо, щоб відображалась тінь нормально

            .zIndex(1)
        }
    #endif

    var body: some View {
        Group {
            #if os(macOS)
                macOSBarView
            #else
                iOSBarView
            #endif
        }
    }
}

struct NavigationBarItem: View {
    @Environment(\.detectedOS) var detectedOS

    @Environment(Router.self) private var router

    #if os(macOS)
        @State private var hovering = false
    #endif

    let tab: Tab

    private var isActive: Bool {
        router.activeTab == tab
    }

    var body: some View {
        ConditionalStack(horizontally: detectedOS == .macOS, vSpacing: 5, hSpacing: 8) {
            Image(systemName: tab.icon)
                .symbolVariant(isActive ? .fill : .none)
                .imageScale(.large)
            #if os(macOS)
                .fontWeight(.bold)
            #else
                .fontWeight(.medium)
            #endif
                .symbolRenderingMode(tab.iconMode)
                .frame(width: 35, height: 35)

            Text(tab.label)
            #if os(iOS)
                .font(.custom("Montserrat", size: 12))
                .fontWeight(.bold)
            #else
                .font(.custom("Montserrat", size: 14))
            #endif

            #if os(macOS)
                Spacer()
            #endif
        }
        #if os(macOS)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .background(isActive || hovering ? .backgroundMain : .clear, in: .rect(cornerRadius: 6))
        .onHover {
            if !isActive {
                hovering = $0
            }
        }

        #else
        .foregroundStyle(router.activeTab == tab ? .selection : .textSecondary)
        #endif
        .onTapGesture {
            router.selectTab(tab)

            #if os(macOS)
                hovering = false
            #endif
        }
    }
}

#Preview {
    HStack(spacing: 0) {
        NavigationBar()
        VStack {
            Text("Hui")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
    .environment(Router.shared)
}
