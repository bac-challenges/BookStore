//
//  ViewController.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
}

