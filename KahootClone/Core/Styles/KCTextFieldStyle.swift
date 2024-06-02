//
//  KCTextFieldStyle.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 06.04.2024.
//

import SwiftUI

struct KCTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .frame(height: 50)
            .textFieldStyle(.plain)
            .background(.black.opacity(0.05), in: .rect(cornerRadius: 8))
            .foregroundStyle(.black)
            .font(.custom("Montserrat", size: 16))
            .tint(.violetMain)
    }
}
