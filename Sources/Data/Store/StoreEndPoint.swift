//
//  StoreEndPoint.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

enum StoreEndPoint: EndPoint {
    
    case characters(q: String = "iOS", start: Int = 0, max: Int = 100)
    
    var baseURL: URL {
        return URL(string: "https://www.googleapis.com/books/v1/")!
    }
    
    var path: String {
        switch self {
        case .characters: return "volumes"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default: return .GET
        }
    }
}

