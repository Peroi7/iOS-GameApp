//
//  LocalData.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import Foundation

struct LocalData {
    
    static let shared = LocalData()
    
    func loadSavedGenres() -> [Int] {
        return UserDefaults.standard.getData([Int].self, forKey:  AppConstants.keyFavoriteGenres)?.uniqued() ?? []
    }
}
