//
//  BookList.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import UIKit
import Combine

private let reuseIdentifier = "Cell"

class BookList: UICollectionViewController {

    var items = [BookViewModel]()
    var repository: Repository!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repository.load()
    }
}

// MARK: - UI
extension BookList {
    
    private func setupView() {
        title = "Books"
        collectionView.register(BookListCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(toggleFilter))
    }
}

// MARK: - Binding
extension BookList {
    private func setupBinding() {
        repository.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.items = items
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Actions
extension BookList {
    @objc private func toggleFilter() {
        repository.toggleFilterFavourites()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BookList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfSets = CGFloat(2)
        
        let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 15))/numberOfSets
        
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}

// MARK: - UICollectionViewDataSource
extension BookList {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BookListCell
        cell.configure(item: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BookList {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let vc = DetailView()
        vc.repository = repository
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
