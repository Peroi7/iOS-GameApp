//
//  GenreCollectionViewCell.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 17/02/2024.
//

import UIKit

class PopularItemsStackView: UIStackView {
    
    private var gameTitleLabel: UILabel!
    private var gameCountLabel: UILabel!
    private var rightCountIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gameTitleLabel = UILabel()
        gameTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        gameTitleLabel.textAlignment = .left
        gameTitleLabel.textColor = .white
        gameTitleLabel.text = "The Witcher 3: Wild Hunt"
        
        
        gameCountLabel = UILabel()
        gameCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        gameCountLabel.textColor = .lightGray
        gameCountLabel.text = "20,563"
        
        axis = .horizontal
        distribution = .fill
        alignment = .fill
        
        spacing = 16
        
        
        addArrangedSubview(gameTitleLabel)
        addArrangedSubview(gameCountLabel)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class GenreCollectionViewCell: UICollectionViewCell, NibProvidable, ReusableView {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var separatorView: UIView!
    
    private var popularItemsStackView: PopularItemsStackView!
    private var verticalItemsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        configure()
        
    }
    
    private func setupViews() {
        verticalItemsStackView = UIStackView()
        verticalItemsStackView.distribution = .fillEqually
        verticalItemsStackView.alignment = .fill
        verticalItemsStackView.axis = .vertical
        verticalItemsStackView.spacing = 4
        
        let popularItemsStackView1 = PopularItemsStackView()
        let popularItemsStackView2 = PopularItemsStackView()
        let popularItemsStackView3 = PopularItemsStackView()


        addSubview(verticalItemsStackView)
        verticalItemsStackView.autoPinEdge(.top, to: .bottom
                                           , of: separatorView, withOffset: 8.0)
        verticalItemsStackView.autoPinEdge(.left, to: .left, of: self, withOffset: 8.0)
        verticalItemsStackView.autoPinEdge(.right, to: .right, of: self, withOffset: -8.0)
        verticalItemsStackView.autoPinEdge(.bottom, to: .bottom
                                           , of: wrapperView, withOffset: -8.0)
        verticalItemsStackView.autoSetDimension(.height, toSize: 60)
        
        verticalItemsStackView.addArrangedSubview(popularItemsStackView1)
        verticalItemsStackView.addArrangedSubview(popularItemsStackView2)
        verticalItemsStackView.addArrangedSubview(popularItemsStackView3)


        
        
       

    }
    
    func configure() {
        
    }
    
}
