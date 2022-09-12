//
//  OBPageViewModelProtocol.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation
import UIKit

protocol OBPageViewModelProtocol {

    var orderedViewControllers: Observable<[UIViewController]> { get }

    func firstController() -> UIViewController?

    func controllersAtIndex(with controller: UIViewController, type: PaginationFlowTypes) -> UIViewController?

    func countOfControllers() -> Int?

    func currentPageAtIndex(of pageViewController: UIPageViewController) -> Array<UIViewController>.Index? 
}
