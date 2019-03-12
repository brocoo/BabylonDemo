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

protocol PostsDataServiceProtocol {
    
    func fetchAuthoredPosts() -> Single<[AuthoredPost]>
}

final class PostsViewModel: NSObject {

    // MARK: - Properties
    
    let reloadTrigger: PublishRelay<Void>
    private let dataService: PostsDataServiceProtocol
    private let authoredPostsRelay: BehaviorRelay<[AuthoredPost]>
    private let errorRelay: PublishRelay<Error>
    private let disposeBag: DisposeBag
    
    // MARK: - Initializer
    
    init(dataProvider: PostsDataServiceProtocol) {
        self.dataService = dataProvider
        self.authoredPostsRelay = BehaviorRelay(value: [])
        self.errorRelay = PublishRelay()
        self.reloadTrigger = PublishRelay()
        self.disposeBag = DisposeBag()
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        
        let data = reloadTrigger
            .flatMapLatest { [weak self] _ -> Observable<Event<[AuthoredPost]>> in
                guard let `self` = self else { return .empty() }
                return self.dataService.fetchAuthoredPosts().asObservable().materialize()
            }.share()
        
        data.flatMapLatest { (event) -> Observable<[AuthoredPost]> in
                switch event {
                case .next(let posts): return Observable.just(posts)
                case .error: return Observable.just([])
                case .completed: return Observable.empty()
                }
            }.bind(to: authoredPostsRelay)
            .disposed(by: disposeBag)
        
        data.flatMapLatest { (event) -> Observable<Error> in
                guard case let .error(error) = event else { return .empty() }
                return Observable.just(error)
            }.bind(to: errorRelay)
            .disposed(by: disposeBag)
    }
}

extension PostsViewModel: PostsViewModelProtocol {

    var authoredPosts: Driver<[AuthoredPost]> { return authoredPostsRelay.asDriver(onErrorJustReturn: []) }
    var error: Signal<Error> { return errorRelay.asSignal() }
}
