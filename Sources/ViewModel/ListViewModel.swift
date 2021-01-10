//
//  ListViewModel.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

final class ListViewModel {
    
    @Published var items = [Book]()
    
    private let service: Service
    
    init(service: Service = RemoteService()) {
        self.service = RemoteService()
        load()
    }
    
    func load() {
        
        let params = ["q": "iOS", "start": "0", "max": "100"]
        
        service.fetch(endpoint: StoreEndPoint.volumes, params: params) { (result: Result<Response, ServiceError>) in
            DispatchQueue.main.sync {
                switch result {
                case .success(let response): self.items = response.books
                case .failure(let error): print(error)
                }
            }
        }
    }
    
    func filter() {
        
    }
}
