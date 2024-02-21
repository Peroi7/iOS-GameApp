//
//  Genre.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import Foundation

public enum GenreItem: Int, Codable {
    case Action = 4
}

struct Genre: Codable {
    
    let id: Int
    let name: String
    let gamesCount: Int
    let imageBackground: String
    let games: [GenrePopularItem]
   
    private enum CodingKeys: String, CodingKey {
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case id, name, games
    }
}

struct GenrePopularItem: Codable {
    let name: String
    let added: Int
}
