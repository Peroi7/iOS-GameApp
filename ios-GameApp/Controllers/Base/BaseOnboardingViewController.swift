//
//  BaseOnboardingViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 16/02/2024.
//

import UIKit
import PureLayout
import IHProgressHUD
import Combine

class BaseOnboardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private enum Constants {
       static let navigationItemTitle: String = "Genres"
    }
     
    var navigationItemTitle: String { return Constants.navigationItemTitle }
    var collectionView: UICollectionView!

    private var separatorView: UIView!
    public var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        addSeparatorView()
        navigationItem.title = navigationItemTitle
        setupCollectionView()
    }
    
    //MARK: - CollectionView

    private func setupCollectionView() {
        let layout = CollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        registerClass()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    public func registerClass() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: "identifier", withReuseIdentifier: UICollectionView.elementKindSectionHeader)
    }
    
    private func addSeparatorView() {
        separatorView = UIView()
        separatorView.backgroundColor = .white
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(separatorView)
        separatorView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        separatorView.autoSetDimension(.height, toSize: 1)
    }
    
    //MARK: - HUD

    func showHud() {
        IHProgressHUD.show()
    }
    
    func dismissHud() {
        IHProgressHUD.dismiss()
    }
    
    //MARK: - Bind

    func bind(item: ViewModel) {
        
    }
    
    //MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    }
 
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
