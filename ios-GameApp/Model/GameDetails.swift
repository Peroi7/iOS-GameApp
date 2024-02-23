//
//  GameDetails.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 23/02/2024.
//

import Foundation

struct GameDetails: Codable {
    
    let id: Int?
    let name: String?
    let backgroundImage: String
    let released: String?
    let playtime: Int?
    let ratings: [Rating]?
    let publishers: [Publisher]?
    let description: String?
    let website: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, released, playtime, ratings, publishers, website
        case description = "description_raw"
        case backgroundImage = "background_image"
    }
}

struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
}

struct Publisher: Codable {
    let name: String
}
