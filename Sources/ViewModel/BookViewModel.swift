//
//  BookViewModel.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import UIKit

struct BookViewModel: Hashable {
    let title: String
    let authors: [String]?
    let description: String
    var image: String
}
