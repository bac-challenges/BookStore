//
//  BookListCell.swift
//  BookStore
//
//  Created by emile on 18/01/2021.
//

import UIKit

class BookListCell: UICollectionViewCell {
    
    var item: BookViewModel?
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true 
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension BookListCell {
    private func setupView() {
        backgroundColor = .lightGray
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        addSubview(imageView)
        setupLayout()
    }
    
    private func setupLayout() {
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    func configure(item: BookViewModel) {
        if let url = URL(string: item.image) {
            imageView.load(url: url)
        }
    }
}

