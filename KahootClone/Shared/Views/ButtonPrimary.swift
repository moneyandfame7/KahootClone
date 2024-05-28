//
//  ButtonPrimary.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import SwiftUI

struct ButtonPrimaryStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme

    var size: ButtonSize
    var variant: ButtonVariant
    var fullWidth = false
    var pressed = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .padding(.horizontal, size.paddingHorizontal)
            .padding(.vertical, size.paddingVertical)
            .font(.custom("Montserrat", size: size.fontSize))
            .fontWeight(size.fontWeight)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(variant.shadowColor)
                        .offset(y: configuration.isPressed || pressed ? 0 : 4)
                        .animation(.easeOut(duration: 0.2), value: configuration.isPressed || pressed)

                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(variant.mainColor)
                }
                .compositingGroup()
                .opacity(isEnabled ? 1 : 0.7)
            )
            .foregroundStyle(variant.labelColor)
            .offset(y: configuration.isPressed || pressed ? 4 : 0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed || pressed)
    }
}

enum ButtonVariant {
    case primary, secondary, violet, green, red, background, surface

    var mainColor: Color {
        switch self {
        case .primary:
            return .blueMain
        case .red:
            return .redMain
        case .secondary:
            return .black
        case .violet:
            return .violetMain
        case .background:
            return .backgroundMain
        case .surface:
            return .surfaceMain
        case .green:
            return .greenMain
        }
    }

    var shadowColor: Color {
        switch self {
        case .primary:
            return .blueDark
        case .red:
            return .redDark
        case .secondary:
            return .black
        case .violet:
            return .violetDark
        case .background:
            return .backgroundDark
        case .surface:
            return .surfaceDark
        case .green:
            return .greenDark
        }
    }

    var labelColor: Color {
        switch self {
        case .background, .surface:
            return .textPrimary
        default:
            return .white
        }
    }
}

enum ButtonSize {
    case small, `default`, large

    var paddingVertical: CGFloat {
        switch self {
        case .small:
            return 5
        case .default:
            return 10
        case .large:
            return 15
        }
    }

    var paddingHorizontal: CGFloat {
        switch self {
        case .small:
            return 10
        case .default:
            return 20
        case .large:
            return 25
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .small:
            return 12
        case .default:
            return 16
        case .large:
            return 18
        }
    }

    var fontWeight: Font.Weight {
        return .bold
    }
}

struct ButtonPrimary: View {
    var title: String?
    var icon: String?

    var size: ButtonSize = .default
    var variant: ButtonVariant = .primary
    var fullWidth = false
    var disabled = false

    var isLoading = false
    var loadingTitle: String?

    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button {
            Task {
                pressed = true
                try? await Task.sleep(for: .seconds(0.1))
                pressed = false
            }
            action()
        } label: {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(variant.labelColor)
                        .padding(.trailing, 5)

                    if let loadingTitle {
                        Text(loadingTitle)
                            .animation(nil)
                    } else if let title {
                        Text(title)
                            .animation(nil)
                    }

                } else {
                    if let icon {
                        Image(systemName: icon)
                            .fontWeight(.medium)
                    }
                    if let title {
                        Text(title)

                            // MARK: обов'язково, щоб не було анімації самого тексту

                            .animation(nil)
                    }
                }
            }
        }
        .buttonStyle(ButtonPrimaryStyle(
            size: size,
            variant: variant,
            fullWidth: fullWidth,
            pressed: pressed
        ))
        .disabled(isLoading)
    }
}

#Preview {
    VStack(spacing: 25) {
        ButtonPrimary(title: "Hui.", action: {})

        ButtonPrimary(title: "Hui.", fullWidth: true, action: {})

        ButtonPrimary(title: "Hui.", variant: .background, action: {})

        ButtonPrimary(title: "Hui.", variant: .surface, action: {})

        ButtonPrimary(title: "Hui.", variant: .red, fullWidth: true, action: {})

        ButtonPrimary(title: "Hui.", size: .small, variant: .violet, action: {})

        ButtonPrimary(
            title: "Hui.",
            size: .small,
            variant: .violet,
            isLoading: true,
            loadingTitle: "Loading...",
            action: {}
        )

        ButtonPrimary(title: "Hui.", icon: "plus", variant: .violet, action: {})
    }
    .frame(width: 300, height: 300)
}
