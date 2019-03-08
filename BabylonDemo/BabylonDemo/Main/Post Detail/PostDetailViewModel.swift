//
//  PostDetailViewModel.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/4/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PostDetailDataServiceProtocol {
    
    func fetchComments(forPostId postId: UInt) -> Single<[Comment]>
}

final class PostDetailViewModel: NSObject {
    
    // MARK: - Properties
    
    private let dataService: PostDetailDataServiceProtocol
    private let commentsRelay: BehaviorRelay<[Comment]>
    let reloadTrigger: PublishRelay<Void>
    let authoredPost: AuthoredPost
    let disposeBag: DisposeBag
    
    // MARK: - Initializer
    
    init(dataService: PostDetailDataServiceProtocol, authoredPost: AuthoredPost) {
        self.dataService = dataService
        self.commentsRelay = BehaviorRelay(value: [])
        self.reloadTrigger = PublishRelay()
        self.authoredPost = authoredPost
        self.disposeBag = DisposeBag()
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        reloadTrigger
            .asDriver(onErrorJustReturn: ())
            .withLatestFrom(Driver.just(authoredPost.post.id))
            .flatMapLatest { [weak self] (postId) -> Driver<[Comment]> in
                guard let `self` = self else { return Driver.empty() }
                return self.dataService
                    .fetchComments(forPostId: postId)
                    .asDriver(onErrorJustReturn: [])
            }.drive(commentsRelay)
            .disposed(by: disposeBag)
    }
}

extension PostDetailViewModel: PostDetailViewModelProtocol {
    
    var comments: Driver<[Comment]> { return commentsRelay.asDriver(onErrorJustReturn: []) }
}
