//
//  GenreResponse.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import Foundation

protocol Responsive: Codable {
    associatedtype T
    var results: [T] { get }
}

struct GenreResponse<T: Codable>: Responsive {
    var results: [T]
}
