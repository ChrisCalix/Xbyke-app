//
//  OnBoardingTest+Helpers.swift
//  Xbyke-appTests
//
//  Created by Christian Calixto on 12/9/22.
//

@testable import Xbyke_app
import UIKit

extension OnBoardingTest {

    internal func makeSUT() -> OnBoardingPageViewController {
        let sut = OnBoardingPageViewController()
        sut.loadViewIfNeeded()
        return sut
    }

    internal func initOnBoardingPagesViewControllers() -> [UIViewController] {
        let simpleToUseVC = OBUseViewController()
        let trackerVC = OBTrackerViewController()
        let progressVC = OBProgressViewController()
        return [simpleToUseVC,trackerVC,progressVC]
    }

    internal func firstController(at pageController: OnBoardingPageViewController) -> OBUseViewController? {
        return pageController.orderedViewControllers.first as? OBUseViewController
    }

    internal func lastController(at pageController: OnBoardingPageViewController) -> OBProgressViewController? {
        return pageController.orderedViewControllers.last as? OBProgressViewController
    }

    internal func previusController(at pageController: OnBoardingPageViewController, from controller: UIViewController) -> UIViewController? {
        return pageController.dataSource?.pageViewController(pageController, viewControllerBefore: controller)
    }

    internal func nextController(at pageController: OnBoardingPageViewController, from controller: UIViewController) -> UIViewController? {
        return pageController.dataSource?.pageViewController(pageController, viewControllerAfter: controller)
    }
    
}
