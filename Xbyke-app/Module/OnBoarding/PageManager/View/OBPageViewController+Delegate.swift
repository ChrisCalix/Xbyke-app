//
//  OBPageViewController+Delegate.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentPage = viewModel?.currentPageAtIndex(of: pageViewController) else {
            return
        }
        pageControl.currentPage = currentPage
    }
}
