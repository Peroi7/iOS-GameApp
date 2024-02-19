//
//  GenreResponse.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import Foundation

struct GenreResponse<T: Codable>: Codable {
    let results: [T]
}
