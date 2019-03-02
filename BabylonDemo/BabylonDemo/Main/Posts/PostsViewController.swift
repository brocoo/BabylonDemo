//
//  PostsViewController.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/1/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

protocol PostsViewModelProtocol { }

final class PostsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostsViewModelProtocol
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initializers
    
    init(viewModel: PostsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Can't be initialized from Storyboard")
    }
    
    // MARK: - UIViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        title = "Posts"
    }
}
