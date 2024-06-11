//
//  BaseUseCase.swift
//  KahootClone
//
//  Created by Davyd Darusenkov on 01.06.2024.
//

import Foundation

protocol BaseUseCase {
    associatedtype Result
    associatedtype Params: Encodable

    func execute(params: Params) async throws -> Result
}

struct EmptyStruct: Codable {}
