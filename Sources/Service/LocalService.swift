//
//  LocalService.swift
//  BookStore
//
//  Created by emile on 18/01/2021.
//

import Foundation

protocol LocalServiceProtocol {
    func load(completionHandler: @escaping ([String]) -> Void)
    func save(items: [String])
}

struct LocalService: LocalServiceProtocol {
    
    private let defaults = UserDefaults.standard
    private let key = "favourites"
    
    func load(completionHandler: @escaping ([String]) -> Void) {
        
        let items = defaults.array(forKey: key) as? [String] ?? [String]()
        
        completionHandler(items)
    }
    
    func save(items: [String]) {
        defaults.set(items, forKey: key)
        
        load { items in
            print(items)
        }
    }
}
