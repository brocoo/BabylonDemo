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
    
    let reloadTrigger: PublishRelay<Void>
    let authoredPost: AuthoredPost
    private let dataService: PostDetailDataServiceProtocol
    private let commentsRelay: BehaviorRelay<[Comment]>
    private let errorRelay: PublishRelay<Error>
    private let disposeBag: DisposeBag
    
    // MARK: - Initializer
    
    init(dataService: PostDetailDataServiceProtocol, authoredPost: AuthoredPost) {
        self.dataService = dataService
        self.commentsRelay = BehaviorRelay(value: [])
        self.errorRelay = PublishRelay()
        self.reloadTrigger = PublishRelay()
        self.authoredPost = authoredPost
        self.disposeBag = DisposeBag()
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        
        let data = reloadTrigger
            .withLatestFrom(Observable.just(authoredPost.post.id))
            .flatMapLatest { [weak self] (postId) -> Observable<Event<[Comment]>> in
                guard let `self` = self else { return .empty() }
                return self.dataService
                    .fetchComments(forPostId: postId)
                    .asObservable()
                    .materialize()
            }.share()
            
        data.flatMapLatest { (event) -> Observable<[Comment]> in
                switch event {
                case .next(let comments): return Observable.just(comments)
                case .error: return Observable.just([])
                case .completed: return Observable.empty()
                }
            }.bind(to: commentsRelay)
            .disposed(by: disposeBag)
        
        data.flatMapLatest { (event) -> Observable<Error> in
            guard case let .error(error) = event else { return .empty() }
            return Observable.just(error)
            }.bind(to: errorRelay)
            .disposed(by: disposeBag)
    }
}

extension PostDetailViewModel: PostDetailViewModelProtocol {
    
    var comments: Driver<[Comment]> { return commentsRelay.asDriver(onErrorJustReturn: []) }
    var error: Signal<Error> { return errorRelay.asSignal() }
}
