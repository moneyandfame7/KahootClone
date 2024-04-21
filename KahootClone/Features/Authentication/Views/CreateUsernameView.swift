//
//  CreateUsernameView.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

import SwiftUI

struct CreateUsernameView: View {
    @Environment(AuthenticationViewModel.self) private var vm

    var body: some View {
        @Bindable var vm = vm

        VStack {
            Text("Create a username")
                .foregroundStyle(.white)
                .font(.custom("Montserrat", size: 24))
                .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)

            VStack {
                TextField("Enter username...", text: $vm.username)
                    .textFieldStyle(KCTextFieldStyle())

                ButtonPrimary(title: "Continue", variant: .primary, fullWidth: true) {
//                    let isExist = vm.isUsernameExist(vm.username)
//                    if isExist { return }

                    withAnimation {
                        vm.signUpStage = .form
                    }
                }
            }
            .frame(maxWidth: 350)
            .padding()
            .background(.surfaceMain, in: .rect(cornerRadius: 8))
            .compositingGroup()
        }
        .padding()
    }
}

#Preview {
    CreateUsernameView()
        .background(.red)
        .environment(AuthenticationViewModel(variant: .signUp))
}
