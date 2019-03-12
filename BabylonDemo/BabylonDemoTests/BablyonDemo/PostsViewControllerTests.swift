//
//  PostsViewControllerTests.swift
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

class PostsViewControllerTests: XCTestCase {
    
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
    
    func testCollectionViewIsPopulated() {
        dataService.postsEvents = [Event.next(AuthoredPost.makeMocks(count: 10))]
        let viewModel = PostsViewModel(dataProvider: dataService)
        let viewController = PostsViewController(viewModel: viewModel, navigationCoordinator: MockNavigationCoordinator())
        XCTAssertNotNil(viewController.view)
        if let collectionView = viewController.view.subviews.last as? UICollectionView {
            XCTAssert(collectionView.numberOfSections == 1)
            XCTAssert(collectionView.numberOfItems(inSection: 0) == 10)
        } else {
            XCTFail()
        }
    }
    
    func testError() {
        dataService.postsEvents = [Event.error(MockError())]
        let viewModel = PostsViewModel(dataProvider: dataService)
        let viewController = PostsViewController(viewModel: viewModel, navigationCoordinator: MockNavigationCoordinator())
        XCTAssertNotNil(viewController.view)
        if let collectionView = viewController.view.subviews.last as? UICollectionView {
            XCTAssert(collectionView.numberOfSections == 1)
            XCTAssert(collectionView.numberOfItems(inSection: 0) == 0)
        } else {
            XCTFail()
        }
    }
}
