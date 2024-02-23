//
//  ArrayExtensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import Foundation

//MARK: - Remove duplicates

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
