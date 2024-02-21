//
//  GenreCollectionViewHeader.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import UIKit
import Combine

class GenreCollectionViewHeader: UICollectionReusableView, ReusableView {
    
    private enum Constants {
        static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let doneButtonFont = UIFont.boldSystemFont(ofSize: 18)
        static let headerText = "Select your favorite genres"
        static let doneButtonSize: CGSize = .init(width: 80, height: 30)
    }
    
    private var headerLabel: UILabel!
    private var doneButton: UIButton!
    
    @Published var isEnabled: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Toggle
    
    private func toggleEnabled() {
        $isEnabled.sink { [weak self](isEnabled) in
            UIView.animate(withDuration: 0.3) {
                self?.doneButton.layer.borderColor = isEnabled ? UIColor.white.cgColor : UIColor.gray.cgColor
                self?.doneButton.setTitleColor(isEnabled ? .white : .gray, for: .normal)
                self?.doneButton.backgroundColor = isEnabled ? .clear : Colors.primaryBackground
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        headerLabel = UILabel()
        headerLabel.text = Constants.headerText
        headerLabel.textColor = .white
        headerLabel.textAlignment = .left
        headerLabel.font = Constants.font
        
        doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.layer.borderWidth = 1
        doneButton.layer.cornerRadius = 4
        doneButton.titleLabel?.font = Constants.doneButtonFont

        addSubview(headerLabel)
        addSubview(doneButton)
                
        headerLabel.autoPinEdge(.left, to: .left, of: self, withOffset: AppConstants.paddingDefault)
        headerLabel.autoPinEdge(.right, to: .left, of: doneButton, withOffset: AppConstants.paddingSmall)
        headerLabel.autoPinEdge(.bottom, to: .bottom, of: self)
        
        doneButton.autoPinEdge(.right, to: .right, of: self, withOffset: -AppConstants.paddingDefault)
        doneButton.autoAlignAxis(.horizontal, toSameAxisOf: headerLabel)
        doneButton.autoSetDimensions(to: Constants.doneButtonSize)
        
        toggleEnabled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
