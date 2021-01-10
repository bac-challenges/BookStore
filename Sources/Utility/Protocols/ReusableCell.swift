//
//  ReusableCell.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

public protocol ReusableCell {
    static var identifier: String { get }
}

public extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}
