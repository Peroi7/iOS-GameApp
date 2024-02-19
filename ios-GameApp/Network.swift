//
//  Network.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 19/02/2024.
//

import UIKit
import Combine

enum Network: String {
    
    //MARK: - Network
    
    case genres = "genres"
    
    static func fetch<T: Codable>(network: Network) -> AnyPublisher<T, Error> {
        switch network {
        case .genres:
            let request = URLComponents(url: Network.baseURL, resolvingAgainstBaseURL: true)!
                .parameters(parameters: ["genres": genres.rawValue, "api_key" : apiKey])
                .request
            return Network.fireRequest(request)
        }
    }
}

extension Network {
    
    //MARK: - Request
    
    private static func fireRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
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
    
    fileprivate static var baseURL: URL {
        if let baseURL = URL(string: "https://api.rawg.io/api/") {
            return baseURL
        }
        return URL(fileURLWithPath: "")
    }
}
