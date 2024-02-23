//
//  UIApplicationExtensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 23/02/2024.
//

import UIKit

extension UIApplication {
    
    func openURL(url: URL?){
        if let url = url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

