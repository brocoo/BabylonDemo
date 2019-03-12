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
    var error: Signal<Error> { get }
    var reloadTrigger: PublishRelay<Void> { get }
}

final class PostsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostsViewModelProtocol
    private let refreshControl = UIRefreshControl(frame: .zero)
    private let navigationCoordinator: NavigationCoordinatorProtocol
    private let disposeBag = DisposeBag()
    private lazy var collectionViewAdapter: CollectionViewAdapter = CollectionViewAdapter(collectionView: collectionView)
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initializers
    
    init(viewModel: PostsViewModelProtocol, navigationCoordinator: NavigationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.navigationCoordinator = navigationCoordinator
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
        title = "POSTS_VIEW_CONTROLLER_TITLE".localized
        collectionView.refreshControl = refreshControl
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
            .map { _ in false }
            .asObservable()
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        let selection = PublishRelay<AuthoredPost>()
        
        Driver
            .combineLatest(viewModel.authoredPosts.distinctUntilChanged(), collectionView.rx.width)
            .map { $0.0.asDataSource(collectionViewWidth: $0.1, emitSelectionOn: selection) }
            .drive(collectionViewAdapter)
            .disposed(by: disposeBag)
        
        selection
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] (authoredPost) in
                self?.navigationCoordinator.navigate(to: .postDetail(authoredPost))
            }).disposed(by: disposeBag)
        
        viewModel
            .error
            .emit(onNext: { [weak self] (error) in
                self?.presentAlert(for: error, retry: {
                    self?.viewModel.reloadTrigger.accept(())
                })
            }).disposed(by: disposeBag)
    }
}
