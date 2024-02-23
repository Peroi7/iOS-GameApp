//
//  OnboardingViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import UIKit

class OnboardingViewController: BaseViewController {
    
    private enum Constants {
        static let headerHeight: CGFloat = 60
    }
    
    private let viewModel = OnboardingGenreViewModel()
    let isEdit: Bool
    
    init(isEdit: Bool) {
        self.isEdit = isEdit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        showHud()
        viewModel.state.sink { _ in
        } receiveValue: {[weak self] state in
            guard let uSelf = self else { return }
            switch state {
            case .loading:
                uSelf.showHud()
            case .loaded(let items):
                uSelf.viewModel.items.append(contentsOf: items)
                DispatchQueue.main.async {
                    uSelf.collectionView.reloadData()
                }
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
        viewModel.editedGenres(isEdit: isEdit)
        cell.onSelected
            .sink {[weak self] (isSelected) in
                guard let uSelf = self else { return }
                uSelf.viewModel.onSelected(button: cell.selectButton, isSelected: isSelected)
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
        header.configure(isEdit: isEdit)
        header.onDismiss = {[weak self] in
            guard let uSelf = self else { return }
            if uSelf.isEdit {
                AppCoordinator.shared.dismissSettings(viewController: uSelf)
            } else {
                AppCoordinator.shared.removeOnboarding(child: uSelf)
            }
        } // better to disimss from viewController
        return header
    }
}
