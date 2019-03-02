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
    
    private let dataProvider: DataProvider
    
    lazy private(set) var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: makePostsViewController())
    }()
    
    // MARK: - Initializer
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init()
    }
    
    // MARK: -
    
    private func makePostsViewController() -> UIViewController {
        let viewModel = PostsViewModel(dataProvider: dataProvider)
        return PostsViewController(viewModel: viewModel)
    }
}
