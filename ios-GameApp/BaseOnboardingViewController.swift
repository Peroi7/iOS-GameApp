//
//  BaseOnboardingViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 16/02/2024.
//

import UIKit
import PureLayout
import IHProgressHUD

class BaseOnboardingViewController: UIViewController {
    
    private enum Constants {
        static let baseOnboardingNavigationTitle = "Genres"
    }
    
    var navigationItemTitle: String { return Constants.baseOnboardingNavigationTitle }
    
    private var separatorView: UIView!
    private var collectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        addSeparatorView()
        navigationItem.title = navigationItemTitle
        
        view.backgroundColor = .white
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        
        let height = layout.estimatedItemSize.height
        layout.itemSize = CGSize(width: (screenWidth - 24) / 2, height:  (screenWidth / 2) * 1.3)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.registerNib(cellClass: GenreCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func addSeparatorView() {
        separatorView = UIView()
        separatorView.backgroundColor = .white
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(separatorView)
        separatorView.autoPinEdge(.top, to: .bottom, of: navigationBar)
        separatorView.autoPinEdge(.left, to: .left, of: navigationBar)
        separatorView.autoPinEdge(.right, to: .right, of: navigationBar)
        separatorView.autoSetDimension(.height, toSize: 1)
    }
    
    func showHud() {
        IHProgressHUD.show()
    }
    
    func dismissHud() {
        IHProgressHUD.dismiss()
    }
    
    }
    
    //MARK: - CollectionView
    
    

//MARK: - NavigationBar Appearance

extension BaseOnboardingViewController {
    
    func setupNavigationBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = Colors.primaryBackground
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.shadowColor = .white
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.isTranslucent = false
        }
    }
}

extension BaseOnboardingViewController: UICollectionViewDataSource {
    
    //MARK: - CollectionViewDataSource

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = collectionViewFlowLayout.estimatedItemSize.height
//        print(height)
//        return .init(width: (UIScreen.main.bounds.width - 24) / 2, height: 250)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
    
}

extension BaseOnboardingViewController: UICollectionViewDelegate {
    
}


extension BaseOnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
}
