//
//  GameDetailsView.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 22/02/2024.
//

import UIKit

class GameDetailsView: UIView, UIGestureRecognizerDelegate {
    
    private enum Constants {
        static let scrollViewContentInset: CGFloat = 80
    }
    
    //MARK: - Views
    
    @IBOutlet weak var averagePlaytimeLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var strechyHeaderContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exceptionalRatingLabel: UILabel!
    @IBOutlet weak var recommendedRatingLabel: UILabel!
    @IBOutlet weak var mehRatingLabel: UILabel!
    @IBOutlet weak var skipRatingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    
    let strechyHeaderView = StrechyHeaderView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        strechyHeaderContainer.addSubview(strechyHeaderView)
        strechyHeaderView.autoPinEdgesToSuperviewEdges()
        averagePlaytimeLabel.layer.borderColor = UIColor.white.cgColor
        scrollView.contentInset.bottom = Constants.scrollViewContentInset
    }
    
    @IBAction func openWebsite(_ sender: UIButton) {
        guard let url = URL(string: sender.titleLabel?.text ?? "") else { return }
        UIApplication.shared.openURL(url: url)
    }
    
    //MARK: - Config
    
    func configure(viewModel: ViewModel) {
        if let viewModel = viewModel as? GameDetailsViewModel {
            releasedLabel.text = viewModel.releasedFormatted
            averagePlaytimeLabel.text = viewModel.playtimeValue
            strechyHeaderView.imageView.sd_imageTransition = .fade
            strechyHeaderView.imageView.sd_setImage(with: viewModel.backgroundURL)
            titleLabel.text = viewModel.name
            exceptionalRatingLabel.text = viewModel.exceptionalRatingValue
            recommendedRatingLabel.text = viewModel.recommendedRatingValue
            mehRatingLabel.text = viewModel.mehRatingValue
            skipRatingLabel.text = viewModel.skipRatingValue
            descriptionLabel.text = viewModel.description
            publisherLabel.text = viewModel.publisher
            websiteButton.setAttributedTitle(viewModel.websiteAttributed, for: .normal)
        }
    }
}
