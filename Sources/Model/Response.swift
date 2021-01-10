//
//  Response.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

struct Response: Codable {
    
    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case total = "totalItems"
        case books = "items"
    }
    
    let kind: String
    let total: Int
    let books: [Book]
}
