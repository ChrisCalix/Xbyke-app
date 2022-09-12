//
//  OnBoardingPageViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    internal lazy var orderedViewControllers: [UIViewController] = {
        return [instanceOnBoardingViewController(screen: .simpleToUse),
                instanceOnBoardingViewController(screen: .trackerDistanceTime),
                instanceOnBoardingViewController(screen: .progress)]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIViews()
    }

    fileprivate func initUIViews() {
        dataSource = self
        view.backgroundColor = .systemBackground

        guard let firstViewController = orderedViewControllers.first else {
            return
        }

        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }


    fileprivate func instanceOnBoardingViewController(screen: OnBoardingScreen) -> UIViewController {
        return UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: screen.viewControllerName)
    }
}
