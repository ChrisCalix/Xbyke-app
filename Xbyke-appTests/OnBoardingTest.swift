//
//  OnBoardingTest.swift
//  Xbyke-appTests
//
//  Created by Christian Calixto on 12/9/22.
//

import XCTest
@testable import Xbyke_app

class OnBoardingTest: XCTestCase {

    func test_init_has_zero_pages() {
        let sut = OnBoardingPageViewController()
        let controllers = sut.viewControllers
        XCTAssertNotNil(controllers)
        XCTAssertTrue(controllers!.isEmpty)
    }

    func test_init_sets_preferred_transition_style() {
        let sut = OnBoardingPageViewController()
        XCTAssertEqual(sut.transitionStyle, .scroll)
    }
}
