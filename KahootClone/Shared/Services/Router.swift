//
//  Router.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import SwiftUI

extension View {
    func withAppRouter() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case let .quiz(id):
                VStack {
                    Text("QUIC: \(id)")
                }
            case let .account(id):
                VStack {
                    Text("ACCOUNT: \(id)")
                }
            case let .category(category):
                CategoryScreen(category: category)
            case .myAccount:
                MyAccountScreen()
            case .settings:
                SettingsScreen()
            case let .authentication(variant):
                AuthenticationScreen(variant: variant)
            }
        }
    }

    func withSheetDestination(destination: Binding<SheetDestination?>) -> some View {
        sheet(item: destination) { destination in
            switch destination {
            case .join:
                JoinView()

            case .createFromScratch:
                VStack {
                    Text("Create")
                }
            }
        }
    }
}

enum RouterDestination: Hashable {
    case quiz(id: String)
    case account(id: String)
    case category(QuizCategory)
    case myAccount
    case settings
    case authentication(variant: AuthenticationVariant)
}

// custom view
enum BottomSheetDestination: Identifiable, Hashable {
    var id: String {
        switch self {
        case .createQuiz:
            return "createQuiz"
        }
    }

    case createQuiz
}

// .sheet()
enum SheetDestination: String, Identifiable, Hashable {
    var id: String {
        return rawValue
    }

    case join
    case createFromScratch
}

// State - selectedTab

enum Tab: String, Identifiable, CaseIterable {
    case home, discover, library, groups, create, join

    var id: String {
        return rawValue
    }

    var label: String {
        switch self {
        case .home:
            return "Home"
        case .discover:
            return "Discover"
        case .groups:
            return "Groups"
        case .library:
            return "Library"
        case .create:
            return "Create"
        case .join:
            return "Join"
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "house"
        case .discover:
            return "safari"
        case .groups:
            return "person.2.crop.square.stack"
        case .library:
            return "square.grid.2x2"
        case .create:
            return "plus.square"
        case .join:
            return "circle.hexagongrid.fill"
            //        case .Profile:
            //            return "person.circle"
            //        }
        }
    }

    var iconMode: SymbolRenderingMode {
        switch self {
        case .join:
            return .multicolor
        default:
            return .monochrome
        }
    }

    @ViewBuilder
    var content: some View {
        Group {
            if self == .home {
                HomeScreen()
            } else if self == .discover {
                VStack {
                    Text("Discover")
                }
            } else if self == .groups {
                VStack {
                    Text("Groups")
                }
            } else if self == .library {
                VStack {
                    Text("Library")
                }
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

@Observable
final class Router {
    var path = NavigationPath()
    var presentedBottomSheet: BottomSheetDestination?

    var activeTab: Tab = .home

    var presentedSheet: SheetDestination?

    public init() {}

    func navigate(to destination: RouterDestination) {
        path.append(destination)
    }

    func navigateBack() {
        path.removeLast()
    }

    func navigateToRoot() {
        path.removeLast(path.count)
    }

    func selectTab(_ tab: Tab) {
        if tab == .create {
            presentedBottomSheet = .createQuiz
            return
        }

        if tab == .join {
            presentedSheet = .join
            return
        }

        activeTab = tab
    }
}

extension Router {
    static let shared = Router()
}
