//
//  Genre.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import Foundation

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
    var name: String
    var added: Int
    
    init(name: String, added: Int) {
        self.name = name
        self.added = added
    }
    
    init() {
        name = ""
        added = 0
    }
}
