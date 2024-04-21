//
//  BottomSheet.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    let onDismiss: () -> Void
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                content()
            }
            .frame(maxWidth: .infinity)
            .background(.surfaceMain, in: .rect(cornerRadius: 2))
            .font(.custom("Montserrat", size: 18))

            ButtonPrimary(title: "Cancel",
                          variant: .surface,
                          fullWidth: true,
                          action: onDismiss)
        }
        #if os(iOS)
        .frame(maxWidth: .infinity)
        #else
        .frame(maxWidth: 300)
        #endif
        .padding()
    }
}

struct BottomSheetModifier<Item: Identifiable, SheetContent: View>: ViewModifier {
    @Binding var item: Item?
    let onDismiss: (() -> Void)?
    @ViewBuilder let sheetContent: (Item) -> SheetContent

    func dismiss() {
        onDismiss?()
        item = nil
    }

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            if let item {
                Color.black.opacity(0.7)
                    .transition(.opacity)
                    .ignoresSafeArea()
                    .zIndex(1)
                BottomSheet(onDismiss: {
                    dismiss()
                }) {
                    sheetContent(item)
                }
                .transition(.offset(y: 500))
                .zIndex(2)
            }
        }
        .frame(maxHeight: .infinity)
        .animation( .linear(duration: 0.3), value: item != nil)
    }
}

extension View {
    func bottomSheet<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        return modifier(BottomSheetModifier(item: item, onDismiss: onDismiss, sheetContent: content))
    }
}

#Preview {
    @State var isEnabled = true
    @State var item: BottomSheetDestination? = .createQuiz
    return VStack {
        Text("Lalallala")
        Text("Lalallala")
        Text("Lalallala")
        Text("Lalallala")
        Text("Lalallala")
        Text("Lalallala")
        Text("Lalallala")
    }
    .bottomSheet(item: $item) { destination in
        switch destination {
        case .createQuiz:
            VStack(spacing: 0) {
                BottomSheetButton("Hui pizda", icon: "square.and.arrow.up.fill") {}

                BottomSheetButton("Hui 222 pizda", icon: "square.and.arrow.up.fill") {}
            }
        }
    }
    // TODO: isPresented, content: ...
}

struct BottomSheetButton: View {
    var label: String
    var icon: String?
    var action: () -> Void

    init(_ label: String, icon: String? = nil, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(label)
                    .background(.surfaceMain)
                    .font(.custom("Montserrat", size: 16))
                    .fontWeight(.medium)

                Spacer()
            }
            .padding()
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        
    }
}
