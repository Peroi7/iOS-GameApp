//
//  Network.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import UIKit
import Combine

fileprivate protocol NetworkApi {
    static func fetchGenres() -> AnyPublisher<Response<Genre>, Error>
    static func fetchGames(page: Int) -> AnyPublisher<Response<Game>, Error>
}

class Network: NetworkApi {
    
    //MARK: - Network
    
    fileprivate enum FetchType: String {
        case genre = "genres"
        case games = "games"
    }
    
    static func fetchGenres() -> AnyPublisher<Response<Genre>, Error> {
        let request = fire(parameters: ["key" : apiKey], type: .genre)
        return Network.fireRequest(request)
    }
    
    static func fetchGames(page: Int) -> AnyPublisher<Response<Game>, Error> {
        let savedGenres = LocalData.shared.loadSavedGenres().map { String($0)}
        let platforms = savedGenres.joined(separator: ",")
        let request = fire(parameters: ["key" : apiKey, "platforms" : platforms, "page_size" : AppConstants.itemsPerPage, "page": page], type: .games)
        return Network.fireRequest(request)
    }
}

extension Network {
    
    //MARK: - Request
    
    private static func fireRequest<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private static func fire(parameters: [String : CustomStringConvertible], type: FetchType) -> URLRequest {
        let request = URLComponents(url: Network.baseURL(type: type), resolvingAgainstBaseURL: false)!
            .parameters(parameters: parameters)
            .request
        return request
    }
}

private extension URLComponents {
    
    //MARK: - Query
    
    func parameters(parameters: [String: CustomStringConvertible]) -> URLComponents {
        var copy = self
        copy.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        return copy
    }
    
    var request: URLRequest {
        if let request = url.map({ URLRequest.init(url: $0) }) {
            return request
        }
        return URLRequest(url: URL(fileURLWithPath: ""))
    }
}

extension Network {
    
    //MARK: - ApiKey/Base
    
    fileprivate static var apiKey: String {
        if let apiKey = Bundle.main.propertyValue(resource: "NetworkSource", key: "api_key")  as? String {
            return apiKey
        }
        return ""
    }
    
    fileprivate static func baseURL(type: FetchType) -> URL {
        if var baseURL = URL(string: "https://api.rawg.io/api/") {
            baseURL.appendPathComponent(type.rawValue)
            return baseURL
        }
        return URL(fileURLWithPath: "")
    }
}
