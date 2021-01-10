//
//  Response.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

struct Response: Codable {
    let kind: String
    let total: Int
    let books: Book
}
