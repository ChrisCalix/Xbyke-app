//
//  OBPageViewController+DataSource.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getNewScreen(type: .before, currentScreen: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNewScreen(type: .after, currentScreen: viewController)
    }

    func getNewScreen(type: PaginationFlowTypes, currentScreen viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let newIndex = type == .before ? currentIndex - 1 : currentIndex + 1
        guard orderedViewControllers.indices.contains(newIndex) else {
            return nil
        }
        return orderedViewControllers[newIndex]
    }
}
