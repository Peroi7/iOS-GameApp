//
//  GenreCollectionViewCell.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 17/02/2024.
//

import UIKit
import SDWebImage
import Combine

class GenreCollectionViewCell: UICollectionViewCell, NibProvidable, ReusableView {
        
    fileprivate enum Constants {
        static let stackViewItemSpacing: CGFloat = 4
        static let stackViewHeight: CGFloat = 60
    }
    
    //MARK: - Views
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var selectButton: SelectButton!
    
    private var cancellables = Set<AnyCancellable>()
    var onSelected = PassthroughSubject<Bool, Never>()
    
    private var firstStackViewItem = PopularItemsView()
    private var secondStackViewItem = PopularItemsView()
    private var thirdStackViewItem = PopularItemsView()
    private var verticalItemsStackView: UIStackView!
    
    @IBAction func onSelect(_ sender: SelectButton) {
        sender.isSelected = !sender.isSelected
        onSelected.send(sender.isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addVerticalStackView()
        setupViews()
    }
    
    //MARK: - Setup
    
    private func addVerticalStackView() {
        verticalItemsStackView = UIStackView(arrangedSubviews: [firstStackViewItem, secondStackViewItem, thirdStackViewItem])
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
        backgroundImageView.layer.addGradient(colors: [Colors.primaryBackground.withAlphaComponent(0.6).cgColor, UIColor.gray.withAlphaComponent(0.45).cgColor])
    }
    
    func configure(viewModel: ViewModel) {
        if let viewModel = viewModel as? OnboardingGenreViewModel {
            genreTitleLabel.attributedText = NSAttributedString(string: viewModel.name ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            
            countLabel.text = viewModel.gamesCount?.decimal()
            
            if let firstItem = viewModel.games.first, let secondItem = viewModel.games.dropFirst().first, let thirdItem = viewModel.games.dropFirst().last  {
                firstStackViewItem.configure(gameTitle: firstItem.name, gameCount: firstItem.added.decimal())
                secondStackViewItem.configure(gameTitle: secondItem.name, gameCount: secondItem.added.decimal())
                thirdStackViewItem.configure(gameTitle: thirdItem.name, gameCount: thirdItem.added.decimal())
            }
            
            backgroundImageView.sd_imageTransition = .fade
            guard let viewModelImage = viewModel.image else { return }
            guard let URL = URL(string: viewModelImage) else { return }
            backgroundImageView.sd_setImage(with: URL)
            
            selectButton.toggleSelection(isSelected: viewModel.isSelected)
        }
    }
}
