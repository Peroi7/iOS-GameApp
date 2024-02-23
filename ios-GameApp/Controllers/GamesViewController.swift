//
//  GamesViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import UIKit

class GamesViewController: BaseViewController {

    let viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$shouldFetchData
            .sink { [weak self](shouldFetch) in
                if shouldFetch {
                    guard let uSelf = self else { return }
                    uSelf.bind(item: uSelf.viewModel)
                    uSelf.viewModel.fetch(isPagging: false)
                }
            }.store(in: &cancellables)
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
                uSelf.viewModel.items.removeAll()
                uSelf.viewModel.items.append(contentsOf: items)
                uSelf.addRightBarButton()
                DispatchQueue.main.async {
                    uSelf.collectionView.reloadData()
                }
                uSelf.dismissHud()
            case .error(let error):
                print(error.localizedDescription)
            case .paging(let newItems):
                uSelf.viewModel.items.append(contentsOf: newItems)
                DispatchQueue.main.async {
                    uSelf.collectionView.reloadData()
                }
                uSelf.dismissHud()
                break
            }
        }.store(in: &cancellables)
    }

    override func registerClass() {
        collectionView.registerNib(cellClass: GameCollectionViewCell.self)
    }
    
    //MARK: - CollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath) as! GameCollectionViewCell
        viewModel.paginate(indexPath: indexPath, items: viewModel.items)
        cell.configure(item: item)
        return cell
    }
    
    override func addSeparatorView() {
        super.addSeparatorView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.items[indexPath.item].id else { return }
        AppCoordinator.shared.pushDetailsViewController(id: id)
    }
}
