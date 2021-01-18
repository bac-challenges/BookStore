//
//  BookViewModel.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

struct BookViewModel {
    let id: String
    let title: String
    let authors: [String]?
    let description: String
    let image: String
    let buyLink: String?
    var favourite: Bool = false
}
