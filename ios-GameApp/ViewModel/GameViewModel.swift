//
//  GameViewModel.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import Foundation
import Combine
import SDWebImage

class GameViewModel: Selection, ViewModel {
    
    var items: [ViewModel] = []
    private var cancellables = Set<AnyCancellable>()
    private (set) var state = PassthroughSubject<State, Never>()
    private var currentPage = 1
    
    var id: Int?
    var name: String?
    private var rating: Decimal?
    private var added: Int?
    private var metacritic: Int?
    private var backgroundImage: String?
        
    var backgroundURL: URL {
        if let URL = URL(string: backgroundImage ?? "") {
            return URL
        }
        return URL(fileURLWithPath: "")
    }
    
    var metacriticValue: String {
        return String(metacritic ?? 0)
    }
    
    var addedCount: String {
        return added?.decimal() ?? ""
    }
    
    var ratingValue: String {
        return String(format: "%.1f", rating?.doubleValue ?? 0)
    }
    
    var imageTransformer: SDImageResizingTransformer {
        return SDImageResizingTransformer(size: CGSize(width: 110, height: 110), scaleMode: .aspectFill)
    }
    
    //MARK: - Pagination
    
    func paginate(indexPath: IndexPath, items: [ViewModel]) {
        let scrollIndex = Int(AppConstants.itemsPerPage - (AppConstants.itemsPerPage * 3/4))
        guard indexPath.item != items.count - scrollIndex else {
            fetch(isPagging: true)
            return }
    }
    
    //MARK: - Init
    
    init(model: Game? = nil) {
        guard let game = model else { return }
        id = game.id
        name = game.name
        added = game.added
        metacritic = game.metacritic
        backgroundImage = game.backgroundImage
        rating = game.rating
    }
    
    //MARK: - Fetch

    func fetch(isPagging: Bool) {
        state.send(.loading)
        Network.fetchGames(page: currentPage)
            .map{ $0.results.map(GameViewModel.init)}
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] completion in
                guard let uSelf = self else { return }
                switch completion {
                case .failure(let error):
                    uSelf.state.send(.error(error))
                case .finished:
                    ()
                }
            } receiveValue: {[weak self] values in
                if isPagging {
                    self?.currentPage += 1
                    self?.state.send(.paging(values))
                } else {
                    self?.state.send(.loaded(values))
                    self?.currentPage += 1
                }
                
            }.store(in: &cancellables)
    }
}


//MARK: - Hashable

extension GameViewModel: Hashable {
    static func == (lhs: GameViewModel, rhs: GameViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
