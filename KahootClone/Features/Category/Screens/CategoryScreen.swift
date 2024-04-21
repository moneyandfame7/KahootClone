//
//  CategoryScreen.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import SwiftUI

struct CategoryScreen: View {
    @Environment(Router.self) private var router

    let category: QuizCategory

    var body: some View {
        VStack {
            Button("Go back") {
                router.navigateBack()
            }
            Image(category.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text(category.rawValue)

        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CategoryScreen(category: .History)
        .environment(Router.shared)
        .frame(minWidth: 400, minHeight: 400)
}
