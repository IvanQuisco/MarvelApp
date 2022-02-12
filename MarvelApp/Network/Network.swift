//
//  Network.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 12/02/22.
//

import Foundation
import UIKit

typealias Timestamp = () -> Double

enum Constants {
    static let apiString: String = "gateway.marvel.com/v1/public/"
}

enum Keys: String {
    case `public` = "pu"
    case `private` = "pr"
}

enum Endpoint: String {
    case characters
}

enum HashBuilder {
    static func build(with timestamp: Double) -> String {
        (String(timestamp) + Keys.private.rawValue + Keys.public.rawValue).MD5
    }
}

enum URLBuilder {
    static func build(endpoint: Endpoint, timestamp: Double, limit: Int = 100, offset: Int = 0) -> URL {
        let api = "https://\(Constants.apiString)"
        let endpoint = endpoint.rawValue
        let hash = "&hash=\(HashBuilder.build(with: timestamp))"
        let timestamp = "?ts=\(timestamp)"
        let publicKey = "&apikey=\(Keys.public.rawValue)"
        let limit = "&limit=\(limit)"
        let offset = "&offset=\(offset)"
        
        let urlString = api + endpoint + timestamp + publicKey + hash + limit + offset
        
        guard
            let url = URL(string: urlString)
        else {
            assertionFailure("Invalid URL")
            return URL(fileURLWithPath: "", relativeTo: nil)
        }
        return url
    }
}

struct CodableFetcher<C: Codable> {
    static func fetch(from url: URL, completion: @escaping (Result<C?,Swift.Error>) -> Void) {
        DataFetcher.fetch(from: url) { result in
            switch result {
            case let .success(data):
                let model = try? JSONDecoder().decode(C.self, from: data)
                completion(.success(model))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

struct DataFetcher {
    static func fetch(from url: URL, completion: @escaping (Result<Data,Swift.Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        .resume()
    }
}


enum Network {
    static func fetchCharacters(
        timestamp: Timestamp = { Date().timeIntervalSince1970 },
        completion: @escaping (Result<[CharacterUIModel], Swift.Error>) -> Void
    ) {
        let url = URLBuilder.build(endpoint: .characters, timestamp: timestamp())
        CodableFetcher<Query>.fetch(from: url) { result in
            switch result {
            case let .success(query):
                let models = query?.data.results.compactMap(CharacterUIModel.init) ?? []
                completion(.success(models))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchImage(
        data: CharacterThumbnail,
        completion: @escaping (Result<Data, Swift.Error>) -> ()
    ) {
        guard let url = URL(string: data.urlString) else {
            struct InvalidURL: Error {}
            completion(.failure(InvalidURL()))
            return
        }
        
        DataFetcher.fetch(from: url, completion: completion)
    }
}
