//
//  PostsViewModel.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/2/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PostsDataProviderProtocol {
    
    func fetchAuthoredPosts() -> Single<[AuthoredPost]>
}

final class PostsViewModel: NSObject {

    // MARK: - Properties
    
    let dataProvider: PostsDataProviderProtocol
    let authoredPostsRelay: BehaviorRelay<[AuthoredPost]>
    let reloadTrigger: PublishRelay<Void>
    let disposeBag: DisposeBag
    
    // MARK: - Initializer
    
    init(dataProvider: PostsDataProviderProtocol) {
        self.dataProvider = dataProvider
        self.authoredPostsRelay = BehaviorRelay(value: [])
        self.reloadTrigger = PublishRelay()
        self.disposeBag = DisposeBag()
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        reloadTrigger
            .asDriver(onErrorJustReturn: ())
            .flatMapLatest { _ in
                return self.dataProvider
                    .fetchAuthoredPosts()
                    .asDriver(onErrorJustReturn: [])
            }
            .drive(authoredPostsRelay)
            .disposed(by: disposeBag)
    }
}

extension PostsViewModel: PostsViewModelProtocol {
    
    var authoredPosts: Driver<[AuthoredPost]> { return authoredPostsRelay.asDriver(onErrorJustReturn: []) }
}
