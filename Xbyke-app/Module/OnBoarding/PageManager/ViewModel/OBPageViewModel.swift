//
//  OBPageViewModel.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation
import UIKit

protocol OBPageViewModelProtocol {

    var orderedViewControllers: Observable<[UIViewController]> { get }
    
}

class OBPageViewModel: OBPageViewModelProtocol {

    var orderedViewControllers: Observable<[UIViewController]>

    init(controllers: [UIViewController]) {
        self.orderedViewControllers = Observable(controllers)
    }

    init(screens: [OnBoardingScreen]) {
        self.orderedViewControllers = Observable(screens.map({
            UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: $0.viewControllerName)
        }))
    }
}
