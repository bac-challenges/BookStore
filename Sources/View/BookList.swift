//
//  BookList.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import UIKit
import Combine

class BookList: UITableViewController {

    var items = [Book]()
    var viewModel: ListViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupView()
    }
}

// MARK: - UI
extension BookList {
    private func setupView() {
        title = "Books"
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: - Binding
extension BookList {
    private func setupBinding() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.items = items
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

// MARK: - UITableViewDataSource
extension BookList {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item.id
        return cell
    }
}

