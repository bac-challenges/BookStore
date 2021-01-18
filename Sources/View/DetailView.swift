//
//  DetailView.swift
//  BookStore
//
//  Created by emile on 14/01/2021.
//

import UIKit

class DetailView: UIViewController {

    var item: BookViewModel!
        
    private let container: UIStackView = {
        let sv = UIStackView()
        sv.axis  = .vertical
        sv.spacing = 10
        sv.alignment = .leading
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        label.text = "Title"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = "Author"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = "Description"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
    }
}

// MARK: - UI
extension DetailView {
    private func setupView() {
        title = "Details"
        view.backgroundColor = .white

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(authorLabel)
        container.addArrangedSubview(descriptionLabel)
        container.addArrangedSubview(UIView())
        
        view.addSubview(container)
        setupLayout()
    }
    
    private func setupLayout() {
        container.anchor(top: view.topAnchor, paddingTop: 80,
                         bottom: view.bottomAnchor,
                         left: view.leftAnchor, paddingLeft: 5,
                         right: view.rightAnchor, paddingRight: 5)
    }
    
    private func updateView() {
        titleLabel.text = item.title
        authorLabel.text = item.authors?.joined(separator: ", ")
        descriptionLabel.text = item.description
        
        if let _ = item.buyLink {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(buy))
        }
    }
}

extension DetailView {
    @objc private func buy() {
        if let url = item.buyLink {
            guard let url = URL(string: url) else { return }
            UIApplication.shared.open(url)
        }
    }
}
