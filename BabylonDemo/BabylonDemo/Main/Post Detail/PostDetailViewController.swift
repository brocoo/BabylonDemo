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
import NetworkKit

protocol PostDetailViewModelProtocol {
    
    var authoredPost: AuthoredPost { get }
    var comments: Driver<[Comment]> { get }
    var error: Signal<Error> { get }
    var reloadTrigger: PublishRelay<Void> { get }
}

final class PostDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostDetailViewModelProtocol
    private let refreshControl = UIRefreshControl(frame: .zero)
    private lazy var collectionViewAdapter: CollectionViewAdapter = CollectionViewAdapter(collectionView: collectionView)
    unowned let navigationCoordinator: NavigationCoordinatorProtocol
    private let disposeBag = DisposeBag()

    // MARK: - IBOutlet properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initializers
    
    init(viewModel: PostDetailViewModelProtocol, navigationCoordinator: NavigationCoordinatorProtocol) {
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
        title = "POST_DETAIL_VIEW_CONTROLLER_TITLE".localized
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
            .comments
            .map { _ in false }
            .asObservable()
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        Driver
            .combineLatest(Driver.just(viewModel.authoredPost), viewModel.comments, collectionView.rx.width)
            .map { PostDetailDataSource(post: $0.0, comments: $0.1, forWidth: $0.2).asDataSource() }
            .drive(collectionViewAdapter)
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .emit(onNext: { [weak self] (error) in
                self?.presentAlert(for: error, retry: {
                    self?.viewModel.reloadTrigger.accept(())
                })
            }).disposed(by: disposeBag)
    }
}
