//
//  OnboardingViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import UIKit

class OnboardingViewController: BaseOnboardingViewController {
    
    private enum Constants {
        static let headerHeight: CGFloat = 60
    }
    
    private let viewModel = OnboardingGenreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(item: viewModel)
        viewModel.fetch()
    }
    
    //MARK: - RegisterClass
    
    override func registerClass() {
        collectionView.registerNib(cellClass: GenreCollectionViewCell.self)
        collectionView.registerHeader(cellClass: GenreCollectionViewHeader.self, kind: UICollectionView.elementKindSectionHeader)
    }
    
    //MARK: - Bind

    override func bind(item: ViewModel) {
        viewModel.state.sink { _ in
        } receiveValue: {[weak self] state in
            guard let uSelf = self else { return }
            switch state {
            case .loading:
                uSelf.showHud()
            case .loaded(let items):
                uSelf.viewModel.items.append(contentsOf: items)
                uSelf.collectionView.reloadData()
                uSelf.dismissHud()
            case .error(let error):
                print(error.localizedDescription)
            case .paging(_):
                break
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath) as! GenreCollectionViewCell
        cell.selectButton.tag = indexPath.item
        let selectedItemIndex = cell.selectButton.tag
        cell.onSelected 
            .sink {[weak self] (isSelected) in
                self?.viewModel.items[selectedItemIndex].isSelected = isSelected
                if let selectedItem = self?.viewModel.items[selectedItemIndex] as? OnboardingGenreViewModel {
                    if let itemId = selectedItem.itemId {
                        self?.viewModel.appendSelectedGenre(isSelected: isSelected, id: itemId)
                    }
                }
            }.store(in: &cancellables)
        cell.configure(viewModel: item)
        
        return cell
    }
    
    //MARK: - CollectionViewHeader
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.headerHeight)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GenreCollectionViewHeader.reuseIdentifier, for: indexPath) as! GenreCollectionViewHeader
        viewModel.$isItemFavorited
            .sink {(value) in
                header.isEnabled = value
            }.store(in: &cancellables)
        return header
    }
}
