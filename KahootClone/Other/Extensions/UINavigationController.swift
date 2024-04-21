//
//  UINavigationController.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 05.04.2024.
//

// https://stackoverflow.com/questions/59921239/hide-navigation-bar-without-losing-swipe-back-gesture-in-swiftui/60067869#60067869 
#if os(iOS)
    import UIKit

    extension UINavigationController: UIGestureRecognizerDelegate {
        override open func viewDidLoad() {
            super.viewDidLoad()
            interactivePopGestureRecognizer?.delegate = self
        }

        public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return viewControllers.count > 1
        }
    }
#endif
