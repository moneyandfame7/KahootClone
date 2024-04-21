//
//  ConditionalStack.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 04.04.2024.
//

import SwiftUI

struct ConditionalStack<Content: View>: View {
    let horizontally: Bool
    let vSpacing: CGFloat
    let hSpacing: CGFloat

    let vAlignment: VerticalAlignment
    let hAlignment: HorizontalAlignment

    let content: () -> Content

    init(
        horizontally: Bool,
        vSpacing: CGFloat = 0,
        hSpacing: CGFloat = 0,
        vAlignment: VerticalAlignment = .center,
        hAlignment: HorizontalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.horizontally = horizontally
        self.vSpacing = vSpacing
        self.hSpacing = hSpacing
        self.vAlignment = vAlignment
        self.hAlignment = hAlignment
        self.content = content
    }

    var body: some View {
        if horizontally {
            HStack(alignment: vAlignment, spacing: hSpacing, content: content)
        } else {
            VStack(alignment: hAlignment, spacing: vSpacing, content: content)
        }
    }
}

#Preview {
    ConditionalStack(horizontally: true, hSpacing: 50) {
        Rectangle()
        Rectangle()
    }
}
