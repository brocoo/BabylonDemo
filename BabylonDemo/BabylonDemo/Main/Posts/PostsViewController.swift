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
    
    var authoredPosts: Driver<[AuthoredPost]> { get }
    var reloadTrigger: PublishRelay<Void> { get }
}

final class PostsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostsViewModelProtocol
    unowned let navigationService: NavigationServiceProtocol
    private lazy var collectionViewAdapter: CollectionViewAdapter = CollectionViewAdapter(collectionView: collectionView)
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initializers
    
    init(viewModel: PostsViewModelProtocol, navigationService: NavigationServiceProtocol) {
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
        title = "Posts"
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
            .authoredPosts
            .drive(onNext: { [weak self] (posts) in
                self?.collectionView.refreshControl?.endRefreshing()
            }).disposed(by: disposeBag)
                
        let width = collectionView.rx
            .bounds
            .map { $0.size.width }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let authoredPosts = viewModel
            .authoredPosts
            .distinctUntilChanged()
        
        Driver
            .combineLatest(authoredPosts, width)
            .map { $0.0.asDataSource(collectionViewWidth: $0.1) }
            .drive(collectionViewAdapter)
            .disposed(by: disposeBag)
        
        collectionViewAdapter
            .onRowSelected
            .asDriver(onErrorDriveWith: Driver.empty())
            .withLatestFrom(authoredPosts) { (index, authoredPosts) -> AuthoredPost in
                return authoredPosts[index]
            }.drive(onNext: { [weak self] (authoredPost) in
                self?.navigationService.navigate(to: .postDetail(authoredPost))
            }).disposed(by: disposeBag)
    }
}
