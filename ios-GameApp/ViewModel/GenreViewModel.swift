//
//  GenreViewModel.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import Foundation
import Combine

class OnboardingGenreViewModel: Selection, ViewModel {
    
    var items: [ViewModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    private (set) var state = PassthroughSubject<State, Never>()
    @Published var isItemFavorited: Bool = false

    var selectedGenres: [Int] {
        get { UserDefaults.standard.getData([Int].self, forKey:  AppConstants.keyFavoriteGenres) ?? []
        }
        set {  UserDefaults.standard.setData(encodable: newValue, forKey: AppConstants.keyFavoriteGenres)
        }
    }
    
    var itemId: Int?
    var name: String?
    var gamesCount: Int?
    var image: String?
    var games: [GenrePopularItem] = []
    
    //MARK: - Init
    init(model: Genre? = nil) {
        guard let model = model else { return }
        itemId = model.id
        name = model.name
        gamesCount = model.gamesCount
        image = model.imageBackground
        games = Array(model.games.prefix(3))
    }

    //MARK: - Fetch
    
    func appendSelectedGenre(isSelected: Bool, id: Int) {
        if isSelected {
            selectedGenres.append(id)
            isItemFavorited = true
        } else {
            selectedGenres.removeAll(where: {$0 == id})
            if selectedGenres.isEmpty {
                isItemFavorited = false
            }
        }
    }
    
    func fetch() {
        state.send(.loading)
        Network.fetchGenres()
            .map{ $0.results.map(OnboardingGenreViewModel.init)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let uSelf = self else { return }
                switch completion {
                case .failure(let error):
                    uSelf.state.send(.error(error))
                case .finished:
                    ()
                }
            } receiveValue: {[weak self] values in
                self?.state.send(.loaded(values))
            }.store(in: &cancellables)
    }
}
