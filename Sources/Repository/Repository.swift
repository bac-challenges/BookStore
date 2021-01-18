//
//  Repository.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import Foundation

final class Repository {
    
    @Published var items = [BookViewModel]()
    private var isFiltered = false
    
    private var originalItems = [BookViewModel]()
    private var localItems = [String]()
    
    private let remoteService: RemoteServiceProtocol
    private let localService: LocalServiceProtocol
    
    init(remoteService: RemoteServiceProtocol = RemoteService(), localService: LocalServiceProtocol = LocalService()) {
        self.remoteService = remoteService
        self.localService = localService
        load()
    }
    
    func load() {
        
        localService.load { items in
            self.localItems = items
        }
        
        let params = ["q": "iOS", "start": "0", "max": "100"]

        remoteService.fetch(endpoint: StoreEndPoint.volumes, params: params) { (result: Result<Response, ServiceError>) in
            DispatchQueue.main.sync {
                switch result {
                case .success(let response): self.items = response.books.map {
                    BookViewModel(id: $0.id,
                                  title: $0.info.title,
                                  authors: $0.info.authors,
                                  description: $0.info.description,
                                  image: $0.info.image.big,
                                  buyLink: $0.saleInfo.buyLink,
                                  favourite: self.localItems.contains($0.id))
                    }
                    self.originalItems = self.items
                case .failure(let error): print(error)
                }
            }
        }
    }
}


// MARK: - Favourites
extension Repository {
    func toggleFilterFavourites() {
        localService.load { items in
            self.localItems = items
        }
        
        isFiltered.toggle()
        
        items = originalItems.map { item in
            var _item = item
            _item.favourite = localItems.contains(item.id)
            return _item
        }.filter { item in
            item.favourite
        }
        
        if !isFiltered {
            items = originalItems
        }
    }
    
    func toggleFavourite(id: String) {
        if let index = items.firstIndex(where: { (item) -> Bool in
            item.id == id
        }) {
            var item = items[index]
            item.favourite.toggle()
            items[index] = item
            
            if item.favourite {
                addFavourite(id: id)
            } else {
                removeFavourite(id: id)
            }
            
            if localItems.count == 0 {
                isFiltered = false
            }
        }
    }
    
    private func removeFavourite(id: String) {
        if let index = localItems.firstIndex(of: id) {
            localItems.remove(at: index)
        }
        localService.save(items: localItems)
    }
    
    private func addFavourite(id: String) {
        if localItems.firstIndex(of: id) == nil {
            localItems.append(id)
        }
        localService.save(items: localItems)
    }
}
