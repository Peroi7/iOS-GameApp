//
//  GenreCollectionViewCell.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 17/02/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell, NibProvidable, ReusableView {
        
    fileprivate enum Constants {
        static let stackViewItemSpacing: CGFloat = 4
        static let stackViewHeight: CGFloat = 60
    }
    
    //MARK: - Views
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var separatorView: UIView!
    
    private var popularItemsStackView: PopularItemsStackView!
    private var verticalItemsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addVerticalStackView()
        setupViews()
    }
    
    //MARK: - Setup
    
    private func addVerticalStackView() {
        verticalItemsStackView = UIStackView()
        verticalItemsStackView.distribution = .fillEqually
        verticalItemsStackView.alignment = .fill
        verticalItemsStackView.axis = .vertical
        verticalItemsStackView.spacing = Constants.stackViewItemSpacing

        addSubview(verticalItemsStackView)
        verticalItemsStackView.autoPinEdge(.top, to: .bottom
                                           , of: separatorView, withOffset: AppConstants.paddingSmall)
        verticalItemsStackView.autoPinEdge(.left, to: .left, of: self, withOffset: AppConstants.paddingSmall)
        verticalItemsStackView.autoPinEdge(.right, to: .right, of: self, withOffset: -AppConstants.paddingSmall)
        verticalItemsStackView.autoPinEdge(.bottom, to: .bottom
                                           , of: wrapperView, withOffset: -AppConstants.paddingSmall)
        verticalItemsStackView.autoSetDimension(.height, toSize: Constants.stackViewHeight)
    }
    
    private func setupViews() {
        selectButton.layer.borderColor = UIColor.white.cgColor
    }
}
