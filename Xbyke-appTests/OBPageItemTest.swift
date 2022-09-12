//
//  OBPageItemTest.swift
//  Xbyke-appTests
//
//  Created by Christian Calixto on 12/9/22.
//

import XCTest
@testable import Xbyke_app

class OBPageItemTest: XCTestCase {

    func test_simple_to_use_started() {
        let sut = makeSUT(with: .simpleToUse)
        XCTAssertEqual(sut.viewModel?.descriptionFromScreen(), "Extremely simple to use")
        XCTAssertEqual(sut.viewModel?.iconFromScreen(), "track")
        XCTAssertTrue(sut.btnContinue.isHidden)
    }

    func test_track_distance_and_time_started() {
        let sut = makeSUT(with: .trackerDistanceTime)
        XCTAssertEqual(sut.viewModel?.descriptionFromScreen(), "Track your time and distance")
        XCTAssertEqual(sut.viewModel?.iconFromScreen(), "distance")
        XCTAssertTrue(sut.btnContinue.isHidden)
    }

    func test_progress_started() {
        let sut = makeSUT(with: .progress)
        XCTAssertEqual(sut.viewModel?.descriptionFromScreen(), "See your progress and challenge yourself!")
        XCTAssertEqual(sut.viewModel?.iconFromScreen(), "progress")
        XCTAssertFalse(sut.btnContinue.isHidden)
    }

}
