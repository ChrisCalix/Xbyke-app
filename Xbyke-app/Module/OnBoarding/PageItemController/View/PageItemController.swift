//
//  PageItemController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation
import UIKit

class PageItemController: UIViewController {

    @IBOutlet weak var onboarding: OnBoardingView!
    @IBOutlet weak var btnContinue: UIButton!
    var viewModel : PageItemViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding.configureView(description: viewModel?.descriptionFromScreen() ,iconName: viewModel?.iconFromScreen(), radius: (onboarding.frame.width-30)/2)
        btnContinue.isHidden = viewModel?.isHiddenButton() ?? false
        btnContinue.layer.cornerRadius = btnContinue.frame.height/2
    }

    func configure(viewModel: PageItemViewModel) {
        self.viewModel = viewModel
    }
    @IBAction func didPresesGetStarted(_ sender: Any) {
        let tabBarVC = UIStoryboard(name: "HomeTabBar", bundle: .main).instantiateViewController(withIdentifier: String(describing:  HomeTabBarController.self))
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true)
    }
}
