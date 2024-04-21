//
//  HomeScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(Router.self) var router

    @ViewBuilder
    var yourKahootsSection: some View {
        LayoutSectionView(icon: "person", title: "Your kahoots") {
            VStack(spacing: 15) {
                Image(.createAKahoot)
                    .resizable()
                    .scaledToFit()
                #if os(iOS)
                    .frame(height: 80)
                #else
                    .frame(height: 120)
                #endif
                Text("Let the games begin!")
                    .font(.custom("Montserrat", size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)

                ButtonPrimary(title: "Create") {
                    print("Create")
                    router.presentedBottomSheet = .createQuiz
                }
            }

            .frame(maxWidth: .infinity)
            .padding()

            .background(.surfaceMain, in: .rect(cornerRadius: 6))
            .compositingGroup()
            .shadow(radius: 2, y: 1)
        }
    }

    @ViewBuilder
    var categoriesSection: some View {
        LayoutSectionView(icon: "number", title: "Categories", button: ("See all", {})) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(QuizCategory.allCases) { category in
                        ZStack(alignment: .bottom) {
                            Image(category.image)
                                .resizable()
                            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                                .opacity(0.8)
                            Text(category.rawValue)
                                .foregroundStyle(.white)
                                .font(.custom("Montserrat", size: 16))
                                .fontWeight(.bold)
                                .offset(y: -10)
                        }
                        .frame(width: 180, height: 100)
                        .clipShape(.rect(cornerRadius: 16))
                        .onTapGesture {
                            router.navigate(to: .category(category))
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    var groupsSection: some View {
        LayoutSectionView(icon: "graduationcap", title: "Groups", button: ("See all", {})) {
            VStack {
                ButtonPrimary(title: "New Group", icon: "plus", variant: .surface) {}
            }
            .frame(maxWidth: .infinity)
        }
    }

    @State private var isCreateQuizSheetPresented = false
    var body: some View {
        VStack(spacing: 0) {
            #if os(iOS)
                HomeHeaderView()
            #endif
            ScrollView {
                VStack(spacing: 50) {
                    categoriesSection

                    yourKahootsSection

                    groupsSection
                }
            }
            .safeAreaPadding(.vertical, 25)
        }
        .background(Color.backgroundMain)
    }
}

#Preview {
    HomeScreen()
        .environment(Router.shared)
}
