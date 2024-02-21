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

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

extension String  {
    var isNumber: Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil && self.rangeOfCharacter(from: CharacterSet.letters) == nil
    }
}
