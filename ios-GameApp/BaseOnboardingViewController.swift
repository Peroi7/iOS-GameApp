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

class BaseOnboardingViewController: UIViewController {
    
    fileprivate enum Constants {
        static let baseOnboardingNavigationTitle = "Genres"
    }
    
    var navigationItemTitle: String { return Constants.baseOnboardingNavigationTitle }
    
    private var separatorView: UIView!
    private var collectionView: UICollectionView!
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        addSeparatorView()
        navigationItem.title = navigationItemTitle
        setupCollectionView()
        

        Network.fetchGenres()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                
             
            } receiveValue: {[weak self] values in
               
                print(values.results.count)
                
            }.store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        let layout = CollectionViewFlowLayout()
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
        separatorView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        separatorView.autoSetDimension(.height, toSize: 1)
    }
    
    func showHud() {
        IHProgressHUD.show()
    }
    
    func dismissHud() {
        IHProgressHUD.dismiss()
    }
    
    }

extension BaseOnboardingViewController: UICollectionViewDataSource {
    
    //MARK: - CollectionViewDataSource

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
    
}

extension BaseOnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
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
