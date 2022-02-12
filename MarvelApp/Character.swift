//
//  Character.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 09/02/22.
//

import Foundation
import UIKit

struct Query: Codable {
    let data: DataQuery
}

struct DataQuery: Codable {
    let results: [CharacterNetworkModel]
}

struct CharacterThumbnail: Codable {
    let path: String
    let `extension`: String
    
    var urlString: String {
        path.replacingOccurrences(of: "http", with: "https") + "." + self.extension
    }
}


typealias CharacterNetworkModel = Character.NetworkModel
typealias CharacterUIModel = Character.UIModel

enum Character {
    struct NetworkModel: Codable {
        let name: String
        let description: String
        let thumbnail: CharacterThumbnail
    }
    
    class UIModel {
        let name: String
        let description: String
        var image: UIImage?
        
        init(from model: NetworkModel) {
            self.name = model.name
            self.description = model.description
        
            Network.fetchImage(data: model.thumbnail) { result in
                if case let .success(data) = result {
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
        }
    }
    
}
