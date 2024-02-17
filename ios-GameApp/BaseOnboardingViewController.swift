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
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        addSeparatorView()
        navigationItem.title = navigationItemTitle
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: GenreCollectionViewCell.self, forIndexPath: indexPath)
        return cell
    }
    
}

extension BaseOnboardingViewController: UICollectionViewDelegate {
    
}
