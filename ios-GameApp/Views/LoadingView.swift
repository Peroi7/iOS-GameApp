//
//  LoadingView.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 09/03/2024.
//

import UIKit
import IHProgressHUD

class LoadingView: UIView {
    
    func show() {
        backgroundColor = Colors.primaryBackground
        IHProgressHUD.show()
    }
    
    func remove() {
        IHProgressHUD.dismiss()
        alpha = .zero
    }
}
