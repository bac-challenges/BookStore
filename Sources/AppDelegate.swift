//
//  AppDelegate.swift
//  BookStore
//
//  Created by emile on 10/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController()
        window?.tintColor = .black
        return true
    }
    
    private func rootViewController() -> UIViewController {
        
        let service = RemoteService()
        let viewModel = ListViewModel(service: service)
        
        let controller = BookList()
        controller.viewModel = viewModel
        return controller
    }
}

