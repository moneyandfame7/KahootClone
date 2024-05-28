//
//  ButtonIcon.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 22.05.2024.
//

import SwiftUI

struct ButtonIcon: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .padding(6)
                .background(.surfaceMain)
                .clipShape(.circle)
                .foregroundStyle(.textPrimary)
                .fontWeight(.semibold)
                
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        ButtonIcon(icon: "xmark") {}
    }
    .frame(width: 300, height: 300)
}
