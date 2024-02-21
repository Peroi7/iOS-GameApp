//
//  GenreCollectionViewHeader.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import UIKit

class GenreCollectionViewHeader: UICollectionReusableView, ReusableView {
    
    private enum Constants {
        static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let headerText = "Select your favorite genres"
    }
    
    private var headerLabel: UILabel!
    
    //MARK: - Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        headerLabel = UILabel()
        headerLabel.text = Constants.headerText
        headerLabel.textColor = .white
        headerLabel.textAlignment = .left
        headerLabel.font = Constants.font
        addSubview(headerLabel)
        
        headerLabel.autoPinEdgesToSuperviewEdges(with: .init(top: 0, left: AppConstants.paddingDefault, bottom: AppConstants.paddingSmall, right: AppConstants.paddingDefault), excludingEdge: .top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
