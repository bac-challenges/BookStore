//
//  Book.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

struct Book: Codable {
    
    struct Info: Codable {
        let title: String
        let authors: [String]?
        let description: String
    }
    
    struct Image: Codable {
        
        enum CodingKeys: String, CodingKey {
            case small = "smallThumbnail"
            case big = "thumbnail"
        }
        
        let small: String
        let big: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case info = "volumeInfo"
        case image = "imageLinks"
    }
    
    let id: String
    let info: Info
    let image: Image?
}
