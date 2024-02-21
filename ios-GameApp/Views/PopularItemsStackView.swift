//
//  PopularItemsStackView.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import UIKit

class PopularItemsView: UIView {
    
    private enum Constants {
        static let itemSpacing: CGFloat = 10
        static let gameTitleLabelFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        static let gameCountLabelFont = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        static let gameCountLabelSize: CGSize = .init(width: 44, height: 20)
    }
    
    //MARK: - Views
    
    private var gameTitleLabel: UILabel!
    private var gameCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        gameTitleLabel = UILabel()
        gameTitleLabel.font = Constants.gameTitleLabelFont
        gameTitleLabel.textAlignment = .left
        gameTitleLabel.textColor = .white
        
        gameCountLabel = UILabel()
        gameCountLabel = UILabel()
        gameCountLabel.font = Constants.gameCountLabelFont
        gameCountLabel.textColor = .systemGray2
        
        addSubview(gameTitleLabel)
        addSubview(gameCountLabel)
        
        gameTitleLabel.autoPinEdge(.left, to: .left, of: self)
        gameTitleLabel.autoPinEdge(.right, to: .left, of: gameCountLabel, withOffset: -AppConstants.paddingSmall)
        
        gameCountLabel.autoPinEdge(.right, to: .right, of: self)
        gameCountLabel.autoPinEdge(.left, to: .right, of: gameTitleLabel)
        gameCountLabel.autoAlignAxis(.horizontal, toSameAxisOf: gameTitleLabel)
        gameCountLabel.autoSetDimensions(to: Constants.gameCountLabelSize)
    }
    
    //MARK: - Configure
    
    func configure(gameTitle: String, gameCount: String) {
        gameTitleLabel.attributedText = NSAttributedString(string: gameTitle, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        gameCountLabel.text = gameCount
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
