//
//  DateExtensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 23/02/2024.
//

import Foundation

extension String {
    
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-d"
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
