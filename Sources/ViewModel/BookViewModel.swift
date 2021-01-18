//
//  BookViewModel.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

struct BookViewModel {
    let title: String
    let authors: [String]?
    let description: String
    var image: String
    var buyLink: String?
}
