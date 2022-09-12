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
        return viewModel?.controllersAtIndex( with: viewController, type: type)
    }
}
