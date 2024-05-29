//
//  Request.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 29.05.2024.
//

import Foundation

struct Request<Response> {
    let url: URL
    var method: HTTPMethod = .get([])

    init(url: String, method: HTTPMethod) {
        self.url = URL(string: url)!
        self.method = method
    }
}
