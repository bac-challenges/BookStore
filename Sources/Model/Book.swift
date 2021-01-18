//
//  Book.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

struct Book: Codable {
    
    struct Info: Codable {
        
        enum CodingKeys: String, CodingKey {
            case title = "title"
            case authors = "authors"
            case description = "description"
            case image = "imageLinks"
        }
        
        let title: String
        let authors: [String]?
        let description: String
        let image: Image
    }
    
    struct Image: Codable {
        
        enum CodingKeys: String, CodingKey {
            case small = "smallThumbnail"
            case big = "thumbnail"
        }
        
        let small: String
        let big: String
    }
    
    struct SaleInfo: Codable {
        let buyLink: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case info = "volumeInfo"
        case saleInfo = "saleInfo"
    }
    
    let id: String
    let info: Info
    let saleInfo: SaleInfo
}
