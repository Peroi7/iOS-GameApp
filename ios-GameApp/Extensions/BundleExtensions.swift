//
//  BundleExtensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import Foundation

extension Bundle {
    
    //MARK: - Plist property
    
    func propertyValue(resource: String?, key: String) -> Any {
        var value: Any?
        let path = Bundle.main.path(forResource: resource, ofType: "plist")
        if let path = path {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
                if !dict.isEmpty {
                    value = dict[key]
                }
            }
        }
        return value ?? fatalError("Property list file \(String(describing: resource)) is missing or mistyped key.")
    }
}
