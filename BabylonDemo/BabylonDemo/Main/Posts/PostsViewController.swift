//
//  PostsViewController.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/1/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PostsViewModelProtocol {
    
    var posts: Driver<[Post]> { get }
    var reloadTrigger: PublishRelay<Void> { get }
}

final class PostsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostsViewModelProtocol
    private let disposeBag = DisposeBag()
    
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
        setupBindings()
        viewModel.reloadTrigger.accept(())
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        title = "Posts"
    }
    
    private func setupBindings() {
        viewModel
            .posts
            .drive(onNext: { (posts) in
                print("[POSTS] \(posts)")
            }).disposed(by: disposeBag)
    }
}
