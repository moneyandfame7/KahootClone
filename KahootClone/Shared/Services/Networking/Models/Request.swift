//
//  Request.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Foundation

struct Request {
    let path: String
    var method: HTTPMethod = .get([])
}
