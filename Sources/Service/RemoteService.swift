//
// RemoteService.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

enum ServiceError: Error {
    case noResponse
    case jsonDecodingError(error: Error)
    case networkError(error: Error)
}

protocol RemoteServiceProtocol {
    func fetch<T: Codable>(endpoint: EndPoint, params: [String: String]?, completionHandler: @escaping (Result<T, ServiceError>) -> Void)
}

struct RemoteService: RemoteServiceProtocol {
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func fetch<T: Codable>(endpoint: EndPoint, params: [String: String]?, completionHandler: @escaping (Result<T, ServiceError>) -> Void) {
        
        let queryURL = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem]()
        
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.noResponse))
                return
            }
            guard error == nil else {
                completionHandler(.failure(.networkError(error: error!)))
                return
            }
            do {
                self.decoder.dateDecodingStrategy = .iso8601
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let object = try self.decoder.decode(T.self, from: data)
                completionHandler(.success(object))
            } catch let error {
                print(error)
                completionHandler(.failure(.jsonDecodingError(error: error)))
            }
        }
        task.resume()
    }
}
