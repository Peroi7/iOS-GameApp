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
    
    //MARK: - Configure

    func configure(viewModel: ViewModel) {
        if let viewModel = viewModel as? OnboardingGenreViewModel {
            genreTitleLabel.attributedText = viewModel.genreAttributed
            countLabel.text = viewModel.gamesCountFormatted
            firstStackViewItem.configure(gameTitle: viewModel.firstStackItem.name, gameCount: viewModel.firstStackItem.added.decimal())
            secondStackViewItem.configure(gameTitle: viewModel.secondStackItem.name, gameCount: viewModel.secondStackItem.added.decimal())
            thirdStackViewItem.configure(gameTitle: viewModel.thirdStackItem.name, gameCount: viewModel.thirdStackItem.added.decimal())
            backgroundImageView.sd_imageTransition = .fade
            backgroundImageView.sd_setImage(with: viewModel.backgroundURL, placeholderImage: nil, context: [.imageTransformer: viewModel.imageTransformer])
            selectButton.toggleSelection(isSelected: viewModel.isSelected)
        }
    }
}
