//
//  PostDetailViewController.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PostDetailViewModelProtocol {
    
    var authoredPost: AuthoredPost { get }
    var comments: Driver<[Comment]> { get }
    var reloadTrigger: PublishRelay<Void> { get }
}

final class PostDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostDetailViewModelProtocol
    private lazy var collectionViewAdapter: CollectionViewAdapter = CollectionViewAdapter(collectionView: collectionView)
    unowned let navigationService: NavigationServiceProtocol
    private let disposeBag = DisposeBag()

    // MARK: - IBOutlet properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initializers
    
    init(viewModel: PostDetailViewModelProtocol, navigationService: NavigationServiceProtocol) {
        self.viewModel = viewModel
        self.navigationService = navigationService
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
    
    // MARK: - Setup
    
    private func setupUI() {
        title = viewModel.authoredPost.post.title
        collectionView.refreshControl = UIRefreshControl(frame: .zero)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    private func setupBindings() {
        
        collectionView.refreshControl?
            .rx
            .controlEvent(.valueChanged)
            .bind(to: viewModel.reloadTrigger)
            .disposed(by: disposeBag)
        
        viewModel
            .comments
            .drive(onNext: { [weak self] (posts) in
                self?.collectionView.refreshControl?.endRefreshing()
            }).disposed(by: disposeBag)
        
        let width = collectionView.rx
            .bounds
            .map { $0.size.width }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: Driver.empty())
        
        Driver
            .combineLatest(Driver.just(viewModel.authoredPost), viewModel.comments, width)
            .map { PostDetailDataSource(post: $0.0, comments: $0.1, forWidth: $0.2).asDataSource() }
            .drive(collectionViewAdapter)
            .disposed(by: disposeBag)
    }
}
