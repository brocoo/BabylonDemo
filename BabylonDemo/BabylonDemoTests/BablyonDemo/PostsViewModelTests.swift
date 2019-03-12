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
    
    private var dataService: MockDataService!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // MARK: - XCTestCase life cycle
    
    override func setUp() {
        super.setUp()
        self.dataService = MockDataService()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests

    func testItEmitsAuthoredPostsAndErrors() {
        dataService.postsEvents = [
            Event.next(AuthoredPost.makeMocks(count: 10)),
            Event.next(AuthoredPost.makeMocks(count: 10)),
            Event.error(MockError()),
            Event.error(MockError()),
            Event.next(AuthoredPost.makeMocks(count: 10)),
            Event.next(AuthoredPost.makeMocks(count: 3)),
            Event.next(AuthoredPost.makeMocks(count: 10))
        ]
        
        let authoredPostsCount = scheduler.createObserver(Int.self)
        let error = scheduler.createObserver(Error.self)
        let viewModel = PostsViewModel(dataProvider: dataService)
        
        viewModel
            .authoredPosts
            .map { $0.count }
            .drive(authoredPostsCount)
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .emit(to: error)
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
        
        let expectedAuthoredPostsCountEvents = Recorded.events(
            .next(0, 0),
            .next(1, 10),
            .next(2, 10),
            .next(3, 0),
            .next(4, 0),
            .next(5, 10),
            .next(6, 3),
            .next(7, 10)
        )
        
        let expectedErrorEvents = Recorded.events(
            .next(3, MockError()),
            .next(4, MockError())
        )
        
        scheduler.start()
        XCTAssert(authoredPostsCount.events == expectedAuthoredPostsCountEvents)
        XCTAssert(error.events.map { $0.time } == expectedErrorEvents.map { $0.time })
    }
}
