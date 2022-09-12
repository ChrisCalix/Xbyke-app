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
        let sut = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingPageViewController") as! OnBoardingPageViewController
        let mockViewModel = OBPageViewModel(controllers: initOnBoardingPagesViewControllers())
        sut.configure(viewModel: mockViewModel)
        sut.loadViewIfNeeded()
        return sut
    }

    internal func makeSUT(controllers: [UIViewController]) -> OnBoardingPageViewController {
        let sut = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingPageViewController") as! OnBoardingPageViewController
        let mockViewModel = OBPageViewModel(controllers: controllers)
        sut.configure(viewModel: mockViewModel)
        sut.loadViewIfNeeded()
        return sut
    }

    internal func initOnBoardingPagesViewControllers() -> [UIViewController] {
        let simpleToUseVC =  UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "PageItemController") as! PageItemController
        let simpleViewModel = PageItemViewModel(screen: .simpleToUse)
        simpleToUseVC.configure(viewModel: simpleViewModel)

        let trackerVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "PageItemController") as! PageItemController
        let trackerViewModel = PageItemViewModel(screen: .trackerDistanceTime)
        trackerVC.configure(viewModel: trackerViewModel)

        let progressVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "PageItemController") as! PageItemController
        let progressViewModel = PageItemViewModel(screen: .simpleToUse)
        progressVC.configure(viewModel: progressViewModel)

        return [simpleToUseVC,trackerVC,progressVC]
    }

    internal func firstController(at pageController: OnBoardingPageViewController) -> PageItemController? {
        return pageController.viewModel?.orderedViewControllers.value?.first as? PageItemController
    }

    internal func lastController(at pageController: OnBoardingPageViewController) -> PageItemController? {
        return pageController.viewModel?.orderedViewControllers.value?.last as? PageItemController
    }

    internal func previusController(at pageController: OnBoardingPageViewController, from controller: UIViewController) -> UIViewController? {
        return pageController.dataSource?.pageViewController(pageController, viewControllerBefore: controller)
    }

    internal func nextController(at pageController: OnBoardingPageViewController, from controller: UIViewController) -> UIViewController? {
        return pageController.dataSource?.pageViewController(pageController, viewControllerAfter: controller)
    }
    
}
