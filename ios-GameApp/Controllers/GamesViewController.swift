//
//  GamesViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import UIKit

class GamesViewController: BaseOnboardingViewController {

    private let viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(item: viewModel)
        viewModel.fetch(isPagging: false)
        
//        addChild(child)
//        child.view.frame = view.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//        self.navigationItem.title = "Genres"
        
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
}
