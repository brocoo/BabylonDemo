//
//  PostDetailViewModelTests.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/11/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import BabylonDemo

class PostDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
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

    func testItEmitsComments() {
        
        let commentsCount = scheduler.createObserver(Int.self)
        dataService.comments = [
            Comment.makeMockData(count: 10),
            Comment.makeMockData(count: 20),
            Comment.makeMockData(count: 7),
            Comment.makeMockData(count: 15)
        ]
        
        let viewModel = PostDetailViewModel(dataService: dataService, authoredPost: AuthoredPost.mock)
        viewModel
            .comments
            .map { $0.count }
            .drive(commentsCount)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(1, ()),
                .next(2, ()),
                .next(3, ()),
                .next(4, ()),
                ]).bind(to: viewModel.reloadTrigger)
            .disposed(by: disposeBag)
        
        let expectedEvents = Recorded.events(
            .next(0, 0),
            .next(1, 10),
            .next(2, 20),
            .next(3, 7),
            .next(4, 15)
        )
        
        scheduler.start()
        XCTAssert(commentsCount.events == expectedEvents)
    }
}
