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

    func testItEmitsComments() {

        dataService.commentsEvents = [
            Event.error(MockError()),
            Event.next(Comment.makeMocks(count: 10)),
            Event.next(Comment.makeMocks(count: 20)),
            Event.error(MockError()),
            Event.next(Comment.makeMocks(count: 7)),
            Event.next(Comment.makeMocks(count: 15))
        ]
        
        let commentsCount = scheduler.createObserver(Int.self)
        let error = scheduler.createObserver(Error.self)
        let viewModel = PostDetailViewModel(dataService: dataService, authoredPost: AuthoredPost.mock)
        
        viewModel
            .comments
            .map { $0.count }
            .drive(commentsCount)
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
                ]).bind(to: viewModel.reloadTrigger)
            .disposed(by: disposeBag)
        
        let expectedEvents = Recorded.events(
            .next(0, 0),
            .next(1, 0),
            .next(2, 10),
            .next(3, 20),
            .next(4, 0),
            .next(5, 7),
            .next(6, 15)
        )
        
        let expectedErrorEvents = Recorded.events(
            .next(1, MockError()),
            .next(4, MockError())
        )
        
        scheduler.start()
        XCTAssert(commentsCount.events == expectedEvents)
        XCTAssert(error.events.map { $0.time } == expectedErrorEvents.map { $0.time })
    }
}
