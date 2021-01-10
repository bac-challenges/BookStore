//
//  Configurable.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

public protocol Configurable {
    associatedtype T
    func configure(_ item: T)
}
