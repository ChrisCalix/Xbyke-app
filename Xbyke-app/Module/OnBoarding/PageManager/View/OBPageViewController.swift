//
//  OnBoardingPageViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var viewModel : OBPageViewModelProtocol?

    init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil, viewModel: OBPageViewModelProtocol) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        configure(viewModel: viewModel)
    }

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIViews()
        initBinds()
    }

    public func configure(viewModel: OBPageViewModelProtocol) {
        self.viewModel = viewModel
    }

    fileprivate func initUIViews() {
        dataSource = self
        view.backgroundColor = .systemBackground
        setFirstControllerInPageController(from: viewModel?.orderedViewControllers.value)
    }


    fileprivate func initBinds() {
        viewModel?.orderedViewControllers.bind{ controllers in
            self.setFirstControllerInPageController(from: controllers)
        }
    }

    fileprivate func setFirstControllerInPageController(from controllers: [UIViewController]?){
        guard let firstViewController = controllers?.first else {
            return
        }
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}
