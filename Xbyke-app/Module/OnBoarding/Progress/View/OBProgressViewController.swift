//
//  ProgressViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OBProgressViewController: UIViewController {

    @IBOutlet weak var onboarding: OnBoardingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        onboarding.configureView(screen: .progress, radius: (onboarding.frame.width-30)/2)
    }

    @IBAction func didPressedGetStarted(_ sender: Any) {
        let tabBarController = UIStoryboard(name: "HomeTrack", bundle: .main).instantiateViewController(withIdentifier: String(describing:  UITabBarController.self))
        tabBarController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(tabBarController, animated: true)
    }

    
}
