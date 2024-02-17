//
//  GenreCollectionViewCell.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 17/02/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell, NibProvidable, ReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configure()
    }
    
    private func setupViews() {
       
    }
    
    func configure() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
