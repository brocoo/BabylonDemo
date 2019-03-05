//
//  NavigationRouter.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/1/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

protocol NavigationServiceProtocol: class {
    
    func navigate(to appPath: AppPath)
}

final class NavigationRouter: NSObject {
    
    // MARK: - Properties
    
    private let dataProvider: DataService
    
    lazy private(set) var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: makePostsViewController())
    }()
    
    // MARK: - Initializer
    
    init(dataProvider: DataService) {
        self.dataProvider = dataProvider
        super.init()
    }
    
    // MARK: -
    
    private func makePostsViewController() -> UIViewController {
        let viewModel = PostsViewModel(dataProvider: dataProvider)
        return PostsViewController(viewModel: viewModel, navigationService: self)
    }
    
    private func makePostDetailsViewController(from authoredPost: AuthoredPost) {
//        let viewModel = PostsViewModel(dataProvider: dataProvider)
//        return PostsViewController(viewModel: viewModel, router: self)
    }
}

extension NavigationRouter: NavigationServiceProtocol {
    
    // MARK: -
    
    func navigate(to appPath: AppPath) {
        
    }
}
