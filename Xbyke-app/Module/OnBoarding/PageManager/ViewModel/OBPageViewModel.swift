//
//  OBPageViewModel.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation
import UIKit

class OBPageViewModel: OBPageViewModelProtocol {

    var orderedViewControllers: Observable<[UIViewController]>

    init(controllers: [UIViewController]) {
        self.orderedViewControllers = Observable(controllers)
    }

    init(screens: [OnBoardingScreen]) {
        self.orderedViewControllers = Observable(screens.map({
            let controller = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: $0.viewControllerName) as! PageItemController
            let viewModel = PageItemViewModel(screen: $0)
            controller.configure(viewModel: viewModel)
            return controller
        }))
    }

    func firstController() -> UIViewController? {
        return orderedViewControllers.value?.first
    }

    func controllersAtIndex(with controller: UIViewController, type: PaginationFlowTypes) -> UIViewController? {
        guard let currentIndex = orderedViewControllers.value?.firstIndex(of: controller) else {
            return nil
        }
        let newIndex = type == .before ? currentIndex - 1 : currentIndex + 1
        guard let controllers = orderedViewControllers.value, controllers.indices.contains(newIndex) else {
            return nil
        }
        return orderedViewControllers.value?[newIndex]
    }

    func countOfControllers() -> Int? {
        return self.orderedViewControllers.value?.count
    }

    func currentPageAtIndex(of pageViewController: UIPageViewController) -> Array<UIViewController>.Index? {

        guard let pageContentViewController = pageViewController.viewControllers?.first, let currentPage = orderedViewControllers.value?.firstIndex(of: pageContentViewController) else {
            return nil
        }
        return currentPage
    }
}
