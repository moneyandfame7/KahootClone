//
//  QuizCategory.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 17.03.2024.
//

import Foundation

enum QuizCategory: String, CaseIterable, Identifiable {
    case Math, Science, History, Kindergarten, Geography

    var id: String {
        return rawValue
    }

    var image: String {
        return rawValue.lowercased()
    }
}
