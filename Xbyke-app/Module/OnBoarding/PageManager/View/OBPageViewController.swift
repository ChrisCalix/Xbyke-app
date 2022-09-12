//
//  OnBoardingPageViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var viewModel : OBPageViewModelProtocol?

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    internal lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = viewModel?.countOfControllers() ?? 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = .clear
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUIViews()
        initBinds()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
    }

    public func configure(viewModel: OBPageViewModelProtocol) {
        self.viewModel = viewModel
    }

    fileprivate func initUIViews() {
        dataSource = self
        delegate = self
        setFirstControllerInPageController(from: viewModel?.firstController())
        view.addSubview(pageControl)
        view.backgroundColor = .orange
        UserDefaults.standard.set(false, forKey: "HideOnBoarding")
    }


    fileprivate func initBinds() {
        viewModel?.orderedViewControllers.bind{ controllers in
            self.setFirstControllerInPageController(from: controllers?.first)
        }
    }

    fileprivate func setFirstControllerInPageController(from controller: UIViewController?){
        guard let firstViewController = controller else {
            return
        }
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}
