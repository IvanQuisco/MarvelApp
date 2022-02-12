//
//  Network.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 12/02/22.
//

import Foundation
import UIKit

enum HashBuilder {
    static func build(with timestamp: Double) -> String {
        (String(timestamp) + Keys.private.rawValue + Keys.public.rawValue).MD5
    }
}

enum URLBuilder {
    static func build(endpoint: Endpoint, timestamp: Double) -> URL {
        let api = Constants.apiString
        let endpoint = endpoint.rawValue
        let hash = HashBuilder.build(with: timestamp)
        let urlString = "https://\(api)\(endpoint)?ts=\(timestamp)&apikey=\(Keys.public.rawValue)&hash=\(hash)"
        print("IQ \(urlString)")
        guard
            let url = URL(string: urlString)
        else {
            assertionFailure("Invalid URL")
            return URL(fileURLWithPath: "", relativeTo: nil)
        }
        return url
    }
}

typealias Timestamp = () -> Double

enum Keys: String {
    case `public` = "pu"
    case `private` = "pr"
}

enum Constants {
    static let apiString: String = "gateway.marvel.com/v1/public/"
}

enum Endpoint: String {
    case characters
}

enum Network {
    static func fetchCharacters(
        timestamp: Timestamp = { Date().timeIntervalSince1970 },
        completion: @escaping (Result<[CharacterNetworkModel], Swift.Error>) -> Void
    ) {
        let url = URLBuilder.build(endpoint: .characters, timestamp: timestamp())
        DataTask.fetch(from: url) { result in
            switch result {
            case let .success(data):
                let query = try? JSONDecoder().decode(Query.self, from: data) as Query
                completion(.success(query?.data.results ?? []))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchImage(
        data: CharacterThumbnail,
        completion: @escaping (Result<Data, Swift.Error>) -> ()
    ) {
        let urlString = data.path.replacingOccurrences(of: "http", with: "https") + "." + data.extension
        guard let url = URL(string: urlString) else {
            struct InvalidURL: Error {}
            completion(.failure(InvalidURL()))
            return
        }
        
        DataTask.fetch(from: url, completion: completion)
    }
}

struct DataTask {
    static func fetch(from url: URL, completion: @escaping (Result<Data,Swift.Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        .resume()
    }
}
