//
//  PopularItemsStackView.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import UIKit

class PopularItemsStackView: UIStackView {
    
    private enum Constants {
        static let itemSpacing: CGFloat = 10
        static let gameTitleLabelFont = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        static let gameCountLabelFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    }
    
    //MARK: - Views
    
    private var gameTitleLabel: UILabel!
    private var gameCountLabel: UILabel!
    private var rightCountIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupStackView()
    }
    
    private func setupStackView() {
        axis = .horizontal
        distribution = .fill
        alignment = .fill
        spacing = Constants.itemSpacing
        addArrangedSubview(gameTitleLabel)
        addArrangedSubview(gameCountLabel)
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        gameTitleLabel = UILabel()
        gameTitleLabel.font = Constants.gameTitleLabelFont
        gameTitleLabel.textAlignment = .left
        gameTitleLabel.textColor = .white
        
        gameCountLabel = UILabel()
        gameCountLabel.font = Constants.gameCountLabelFont
        gameCountLabel.textColor = .systemGray2
    }
    
    func configure(gameTitle: String, gameCount: String) {
        gameTitleLabel.text = gameTitle
        gameCountLabel.text = gameCount
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
