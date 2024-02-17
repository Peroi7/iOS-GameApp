//
//  GenreCollectionViewCell.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 17/02/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    var genreTitleLabel: UILabel!
    var selectButton: UIButton!
    var popularItemsLabel: UILabel!
    var itemsCountLabel: UILabel!
    var popularItemsStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configure()
    }
    
    private func setupViews() {
        genreTitleLabel = UILabel()
        addSubview(genreTitleLabel)
        
        genreTitleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: Constants.paddingDefault)
        genreTitleLabel.autoPinEdge(.left, to: .left, of: self, withOffset: Constants.paddingDefault)
        genreTitleLabel.autoPinEdge(.right, to: .right, of: self, withOffset: -Constants.paddingDefault)
        
    }
    
    func configure() {
        genreTitleLabel.textColor = .white
        genreTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        let attributedText = NSAttributedString(string: "Action", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
        genreTitleLabel.attributedText = attributedText
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
