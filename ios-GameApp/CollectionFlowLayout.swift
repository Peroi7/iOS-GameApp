//
//  CollectionFlowLayout.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate enum Constants {
        static let minimumLineSpacing: CGFloat = 10
        static let minimumInterItemSpacing: CGFloat = 1
        static let itemHeight: CGFloat = 220
    }
    
    fileprivate var contentWidth: CGFloat {
        return UIScreen.main.bounds.width // could also use collectionView
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup

    private func setup() {
        sectionInset = .init(top: AppConstants.paddingDefault, left: AppConstants.paddingSmall, bottom: AppConstants.paddingSmall, right: AppConstants.paddingSmall)
        minimumLineSpacing = Constants.minimumLineSpacing
        minimumInteritemSpacing = Constants.minimumInterItemSpacing
        itemSize = .init(width: (contentWidth - 3 * AppConstants.paddingSmall) / 2, height: Constants.itemHeight)
    }
}
