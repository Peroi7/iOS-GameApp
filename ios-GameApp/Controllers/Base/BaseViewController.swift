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

class BaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    private var separatorView: UIView!
    public var cancellables = Set<AnyCancellable>()
    public var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        setupCollectionView()
        addSeparatorView()
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
    
    func addRightBarButton() {
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: .plain, target: self, action: #selector(onSettings))
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    @objc func onSettings() {
        AppCoordinator.shared.openSettings(parent: self)
    }
    
   func addSeparatorView() {
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
    
    //MARK: - LoadingView
    
    func showLoadingView() {
        view.addSubview(loadingView)
        let navigationBarHeight =  navigationController?.navigationBar.frame.height ?? 0
        let topOffset = AppConstants.detailsImageViewHeight + navigationBarHeight
        loadingView.autoPinEdgesToSuperviewSafeArea(with: .init(top: topOffset, left: 0, bottom: 0, right: 0))
        loadingView.show()
    }
    
    func removeLoadingView() {
        loadingView.remove()
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

extension BaseViewController {
    
    func setupNavigationBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = Colors.primaryBackground
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.shadowColor = .white
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.barTintColor = Colors.primaryBackground
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.isTranslucent = false
        }
    }
}
