//
//  UIViewExtensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 23/02/2024.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
