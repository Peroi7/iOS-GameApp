//
//  GameDetailsViewModel.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 23/02/2024.
//

import Foundation
import Combine
import SDWebImage

class GameDetailsViewModel: Selection, ViewModel {
    
    var items: [ViewModel] = []
    private var cancellables = Set<AnyCancellable>()
    private (set) var state = PassthroughSubject<State, Never>()
    
    var id: Int?
    var name: String?
    var playtime: Int?
    var description: String?
    var website: String?
    private var backgroundImage: String?
    private var released: String?
    private var ratings: [Rating]?
    private var publishers: [Publisher]?
    
    private enum RatingType: String {
        case exceptional = "exceptional"
        case recommended = "recommended"
        case meh = "meh"
        case skip = "skip"
    }
    
    var releasedFormatted: String {
        return released?.toDateString() ?? ""
    }
    
    var playtimeValue: String {
        return "AVERAGE PLAYTIME: \(playtime ?? 0) H"
    }
    
    var backgroundURL: URL {
        if let URL = URL(string: backgroundImage ?? "") {
            return URL
        }
        return URL(fileURLWithPath: "")
    }
    
    var safeRatings: [Rating] {
        if let ratings = ratings {
            return ratings
        }
        return []
    }
    
    var exceptionalRatingValue: String {
        let value = "\(safeRatings.first(where: {$0.title == RatingType.exceptional.rawValue})?.count ?? 0)"
        return "\(RatingType.exceptional.rawValue.firstCapitalized): \(value)"
    }
    
    var recommendedRatingValue: String {
        let value = "\(safeRatings.first(where: {$0.title == RatingType.recommended.rawValue})?.count ?? 0)"
        return "\(RatingType.recommended.rawValue.firstCapitalized): \(value)"
    }
    
    var mehRatingValue: String {
        let value = "\(safeRatings.first(where: {$0.title == RatingType.meh.rawValue})?.count ?? 0)"
        return "\(RatingType.meh.rawValue.firstCapitalized): \(value)"
    }
    
    var skipRatingValue: String {
        let value = "\(safeRatings.first(where: {$0.title == RatingType.skip.rawValue})?.count ?? 0)"
        return "\(RatingType.skip.rawValue.firstCapitalized): \(value)"
    }
    
    var publisher: String {
        return publishers?.first?.name ?? ""
    }
    
    var websiteAttributed: NSAttributedString {
      return NSAttributedString(string: website ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    //MARK: - Init

    init(model: GameDetails? = nil) {
        guard let model = model else { return }
        id = model.id
        name = model.name
        backgroundImage = model.backgroundImage
        released = model.released
        playtime = model.playtime
        ratings = model.ratings
        description = model.description
        publishers = model.publishers
        website = model.website
    }
    
    //MARK: - Fetch

    func fetch(id: Int) {
        state.send(.loading)
        Network.fetchDetails(id: id)
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
                guard let uSelf = self else { return }
                let items = [values].map{GameDetailsViewModel.init(model: $0)}
                uSelf.items.append(contentsOf: items)
                uSelf.state.send(.loaded(uSelf.items))
            }.store(in: &cancellables)
    }
}
