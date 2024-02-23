//
//  GenreViewModel.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import UIKit
import Combine
import SDWebImage

class OnboardingGenreViewModel: Selection, ViewModel {
    
    var items: [ViewModel] = []
    private var cancellables = Set<AnyCancellable>()
    private (set) var state = PassthroughSubject<State, Never>()
    @Published var isItemFavorited: Bool = false

    var selectedGenres: [Int] {
        get { LocalData.shared.loadSavedGenres()
        }
        set {  UserDefaults.standard.setData(encodable: newValue, forKey: AppConstants.keyFavoriteGenres)
        }
    }
    
    //MARK: - Init
    
    init(model: Genre? = nil) {
        guard let model = model else { return }
        id = model.id
        name = model.name
        gamesCount = model.gamesCount
        image = model.imageBackground
        games = Array(model.games.prefix(3))
    }
    
    var id: Int?
    var name: String?
    private var image: String?
    private var gamesCount: Int?
    private var games: [GenrePopularItem] = []
    
    var backgroundURL: URL {
        if let URL = URL(string: image ?? "") {
            return URL
        }
        return URL(fileURLWithPath: "")
    }
    
    var gamesCountFormatted: String {
        return gamesCount?.decimal() ?? ""
    }
    
    var firstStackItem: GenrePopularItem {
        if let firstStackItem = games.first {
            return .init(name: firstStackItem.name, added: firstStackItem.added)
        }
        return .init()
    }
    
    var secondStackItem: GenrePopularItem {
        if let secondStackItem = games.dropFirst().first {
            return .init(name: secondStackItem.name, added: secondStackItem.added)
        }
        return .init()
    }
    
    var thirdStackItem: GenrePopularItem {
        if let thirdStackItem = games.dropFirst().last {
            return .init(name: thirdStackItem.name, added: thirdStackItem.added)
        }
        return .init()
    }
    
    var genreAttributed: NSAttributedString {
        return NSAttributedString(string: name ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    var imageTransformer: SDImageResizingTransformer {
        return SDImageResizingTransformer(size: CGSize(width: 110, height: 110), scaleMode: .aspectFill)
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
    
    func editedGenres(isEdit: Bool) {
        if isEdit {
            selectedGenres.forEach { (id) in
                guard  let selectedItemIndex = items.firstIndex(where: {$0.id == id}) else { return }
                items[selectedItemIndex].isSelected = true
            }
        }
    }
    
    func onSelected(button: UIButton, isSelected: Bool) {
        items[button.tag].isSelected = isSelected
        if let selectedItem = items[button.tag] as? OnboardingGenreViewModel {
            if let itemId = selectedItem.id {
               appendSelectedGenre(isSelected: isSelected, id: itemId)
            }
        }
    }
    
    //MARK: - Init
    
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
