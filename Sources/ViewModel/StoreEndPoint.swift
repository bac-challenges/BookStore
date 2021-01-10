//
//  StoreEndPoint.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

enum StoreEndPoint: EndPoint {
    
    case volumes
    
    var baseURL: URL {
        return URL(string: "https://www.googleapis.com/books/v1/")!
    }
    
    var path: String {
        switch self {
        case .volumes: return "volumes"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default: return .GET
        }
    }
}

