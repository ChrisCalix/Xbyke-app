//
//  OnBoardingTest.swift
//  Xbyke-appTests
//
//  Created by Christian Calixto on 12/9/22.
//

import XCTest
@testable import Xbyke_app

class OnBoardingTest: XCTestCase {

    func test_init_has_non_zero_pages() {
        let controllers = makeSUT().viewControllers
        XCTAssertNotNil(controllers)
        XCTAssertFalse(controllers!.isEmpty)
    }

    func test_init_sets_preferred_transition_style() {
        XCTAssertEqual(makeSUT().transitionStyle, .scroll)
    }

    func test_init_sets_preferred_navigation_orientation() {
        XCTAssertEqual(makeSUT().navigationOrientation, .horizontal)
    }

    func test_viewdidload_withMoreThanZeroPages_set_initial_view_controller() {
        let orderedViewControllers = initOnBoardingPagesViewControllers()
        let sut = makeSUT()

        XCTAssertEqual(sut.orderedViewControllers.count, orderedViewControllers.count)
    }

    func test_next_view_controller_page_index() {
        let sut = makeSUT()
        XCTAssertNotNil(nextController(at: sut, from: firstController(at: sut)!))
    }

    func test_previous_view_controller_page_index() {
        let sut = makeSUT()
        XCTAssertNotNil(previusController(at: sut, from: lastController(at: sut)!))
    }

    func test_nil_controller_after_when_max_number_of_range_reached() {
        let sut = makeSUT()
        XCTAssertNil(nextController(at: sut, from: lastController(at: sut)!))
    }

    func test_nil_controller_before_when_min_number_of_range_reached() {
        let sut = makeSUT()
        XCTAssertNil(previusController(at: sut, from: firstController(at: sut)!))
    }

}
