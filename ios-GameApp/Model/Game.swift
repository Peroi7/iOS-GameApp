//
//  Game.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import Foundation

struct Game: Codable {
    
    let id: Int?
    let name: String?
    let added: Int?
    let rating: Decimal?
    let metacritic: Int?
    let backgroundImage: String?
   
    private enum CodingKeys: String, CodingKey {
        case id, name, added, rating, metacritic
        case backgroundImage = "background_image"
    }
}
