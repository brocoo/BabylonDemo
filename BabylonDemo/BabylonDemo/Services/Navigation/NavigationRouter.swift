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
    
    private let dataService: DataService
    
    lazy private(set) var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: makePostsViewController())
    }()
    
    // MARK: - Initializer
    
    init(dataService: DataService) {
        self.dataService = dataService
        super.init()
    }
    
    // MARK: -
    
    fileprivate func makePostsViewController() -> UIViewController {
        let viewModel = PostsViewModel(dataProvider: dataService)
        return PostsViewController(viewModel: viewModel, navigationService: self)
    }
    
    fileprivate func makePostDetailsViewController(from authoredPost: AuthoredPost) -> UIViewController {
        let viewModel = PostDetailViewModel(dataService: dataService, authoredPost: authoredPost)
        return PostDetailViewController(viewModel: viewModel, navigationService: self)
    }
}

extension NavigationRouter: NavigationServiceProtocol {
    
    // MARK: -
    
    func navigate(to appPath: AppPath) {
        switch appPath {
        case .posts:
            navigationController.popToRootViewController(animated: true)
        case .postDetail(let post):
            let viewController = makePostDetailsViewController(from: post)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
