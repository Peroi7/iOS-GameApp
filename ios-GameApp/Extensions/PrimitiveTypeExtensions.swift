//
//  PrimitiveTypeExtensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import Foundation

extension Int {
    
    func decimal() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}
