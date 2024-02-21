//
//  GameCollectionViewCell.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import UIKit
import SDWebImage

class GameCollectionViewCell: UICollectionViewCell, NibProvidable, ReusableView {
    
    //MARK: - Views
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addedGameLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        metacriticLabel.layer.borderColor = Colors.primaryGreen.cgColor
    }
    
    //MARK: - Config
    
    func configure(item: ViewModel) {
        if let item = item as? GameViewModel {
            titleLabel.text = item.name
            backgroundImageView.sd_imageTransition = .fade
            backgroundImageView.sd_setImage(with: item.backgroundURL, placeholderImage: nil, context: [.imageTransformer: item.imageTransformer])
            metacriticLabel.text = item.metacriticValue
            addedGameLabel.text = item.addedCount
            ratingLabel.text = item.ratingValue
        }
    }
}
