//
//  SelectButton.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import UIKit

class SelectButton: UIButton {
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Toggle
    
    func toggleSelection(isSelected: Bool) {
        backgroundColor = isSelected ? UIColor.white : UIColor.clear
        setTitleColor(isSelected ? Colors.primaryBackground : UIColor.white, for: .normal)
        setTitle(isSelected ? "Selected" : "Select", for: .normal)
    }
    
    override var isSelected: Bool {
        didSet {
            toggleSelection(isSelected: isSelected)
        }
    }
}
