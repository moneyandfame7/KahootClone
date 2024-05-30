//
//  ContentView.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import Factory
import SwiftUI

struct ContentView: View {
    @Injected(\.router) private var router

    #if os(iOS)
        @ViewBuilder
        var iOSLayout: some View {
            VStack(spacing: 0) {
                router.activeTab.content
                NavigationBar()
            }
        }
    #endif

    #if os(macOS)
        @ViewBuilder
        var macOSLayout: some View {
            HStack(spacing: 0) {
                NavigationBar()
                router.activeTab.content
            }
        }
    #endif

    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.path) {
            Group {
                #if os(macOS)
                    macOSLayout
                #else
                    iOSLayout
                #endif
            }
            .withAppRouter()
            .withSheetDestination(destination: $router.presentedSheet)
            .bottomSheet(item: $router.presentedBottomSheet, onDismiss: {}) { destination in
                switch destination {
                case .createQuiz:
                    VStack {
                        BottomSheetButton("Hui pizda", icon: "square.and.arrow.up.fill") {
                            router.presentedBottomSheet = nil
                            router.presentedSheet = .createFromScratch
                        }

                        BottomSheetButton("Hui 222 pizda", icon: "square.and.arrow.up.fill") {}
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
