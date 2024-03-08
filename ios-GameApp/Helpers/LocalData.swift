//
//  LocalData.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import Foundation

struct LocalData {
    
    static let shared = LocalData()
    
    var isEmpty: Bool {
        return loadSavedGenres().count == 0
    }
    
    func loadSavedGenres() -> [Int] {
        return UserDefaults.standard.getData([Int].self, forKey:  AppConstants.keyFavoriteGenres)?.uniqued() ?? []
    }
}
