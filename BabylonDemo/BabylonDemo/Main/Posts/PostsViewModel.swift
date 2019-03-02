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
    
    func fetchPosts() -> Single<[Post]>
}

final class PostsViewModel: NSObject {

    // MARK: - Properties
    
    let dataProvider: PostsDataProviderProtocol
    let postsRelay: BehaviorRelay<[Post]>
    let reloadTrigger: PublishRelay<Void>
    let disposeBag: DisposeBag
    
    // MARK: - Initializer
    
    init(dataProvider: PostsDataProviderProtocol) {
        self.dataProvider = dataProvider
        self.postsRelay = BehaviorRelay(value: [])
        self.reloadTrigger = PublishRelay()
        self.disposeBag = DisposeBag()
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        reloadTrigger
            .asDriver(onErrorJustReturn: ())
            .flatMapLatest { self.dataProvider.fetchPosts().asDriver(onErrorJustReturn: []) }
            .drive(postsRelay)
            .disposed(by: disposeBag)
    }
}

extension PostsViewModel: PostsViewModelProtocol {
    
    var posts: Driver<[Post]> { return postsRelay.asDriver(onErrorJustReturn: []) }
}
