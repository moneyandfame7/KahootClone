//
//  LayoutSectionView.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import SwiftUI

struct LayoutSectionView<Content: View>: View {
    let icon: String
    let title: String

    var button: (title: String, action: () -> Void)?
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: icon)
                    .imageScale(.medium)
                Text(title)
                    .fontWeight(.bold)
                
                Spacer()
                if let button {
                    Button(button.title, action: button.action)
                        .foregroundStyle(.textSecondary)
                        .fontWeight(.bold)
                        .buttonStyle(.plain)
                        .font(.custom("Montserrat", size: 14))
                }
            }
            .foregroundStyle(.textPrimary)
            .font(.custom("Montserrat", size: 16))
            
            content()
        }
        .frame(maxWidth: .infinity)
        .safeAreaPadding(.horizontal, 10)
    }
}

#Preview {
    LayoutSectionView(icon: "person.fill", title: "Categories",
                button: ("Edit", { print("Hui") }))
    {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Rectangle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(width: 50, height: 50)
            }
        }
    }
}
