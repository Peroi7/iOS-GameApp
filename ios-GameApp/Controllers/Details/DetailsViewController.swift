//
//  DetailsViewController.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 22/02/2024.
//

import UIKit
import SDWebImage

class DetailsViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    private var gameDetailsView: GameDetailsView!
    private let viewModel = GameDetailsViewModel()
    let id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
        bind(item: viewModel)
        viewModel.fetch(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameDetailsView()
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
                guard let item = items.first else { return }
                uSelf.gameDetailsView.configure(viewModel: item)
                uSelf.dismissHud()
            case .error(let error):
                print(error.localizedDescription)
            case .paging(_):
                break
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - Setup
    
    private func setupGameDetailsView() {
        gameDetailsView = GameDetailsView.fromNib()
        view.addSubview(gameDetailsView)
        gameDetailsView.autoPinEdgesToSuperviewEdges()
    }
    
    override func addSeparatorView() {}
}
