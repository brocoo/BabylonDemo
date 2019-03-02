//
//  NavigationRouter.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/1/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

final class NavigationRouter: NSObject {
    
    // MARK: - Properties
    
    lazy private(set) var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: makePostsViewController())
    }()
    
    // MARK: - Initializer
    
    override init() {
        super.init()
    }
    
    // MARK: -
    
    private func makePostsViewController() -> UIViewController {
        let viewModel = PostsViewModel()
        return PostsViewController(viewModel: viewModel)
    }
}
