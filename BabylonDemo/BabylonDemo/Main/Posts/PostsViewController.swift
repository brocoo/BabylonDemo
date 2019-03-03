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
        let reloadTrigger = UIRefreshControl(frame: .zero)
        reloadTrigger.rx.controlEvent(.valueChanged).bind(to: viewModel.reloadTrigger).disposed(by: disposeBag)
        collectionView.refreshControl = reloadTrigger
    }
    
    private func setupBindings() {
        viewModel
            .posts
            .drive(onNext: { [weak self] (posts) in
                self?.collectionView.refreshControl?.endRefreshing()
                print("[POSTS] \(posts.count)")
            }).disposed(by: disposeBag)
    }
}
