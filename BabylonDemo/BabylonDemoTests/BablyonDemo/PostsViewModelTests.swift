//
//  PostsViewModelTests.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import BabylonDemo

final class PostsViewModelTests: XCTestCase {
    
    private var dataService: MockDataProvider!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // MARK: - XCTestCase life cycle
    
    override func setUp() {
        super.setUp()
        self.dataService = MockDataProvider()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests

    func testItEmitsAuthoredPosts() {
        
        let authoredPosts = scheduler.createObserver(Int.self)
        dataService.posts = [
            AuthoredPost.makeMockData(count: 10),
            AuthoredPost.makeMockData(count: 10),
            AuthoredPost.makeMockData(count: 10),
            AuthoredPost.makeMockData(count: 7),
            AuthoredPost.makeMockData(count: 10),
            AuthoredPost.makeMockData(count: 3),
            AuthoredPost.makeMockData(count: 10),
        ]
        
        let viewModel = PostsViewModel(dataProvider: dataService)
        viewModel
            .authoredPosts
            .map { $0.count }
            .drive(authoredPosts)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(1, ()),
                .next(2, ()),
                .next(3, ()),
                .next(4, ()),
                .next(5, ()),
                .next(6, ()),
                .next(7, ()),
            ]).bind(to: viewModel.reloadTrigger)
            .disposed(by: disposeBag)
        
        let expectedEvents = Recorded.events(
            .next(0, 0),
            .next(1, 10),
            .next(2, 10),
            .next(3, 10),
            .next(4, 7),
            .next(5, 10),
            .next(6, 3),
            .next(7, 10)
        )
        
        scheduler.start()
        XCTAssert(authoredPosts.events == expectedEvents)
    }
}
