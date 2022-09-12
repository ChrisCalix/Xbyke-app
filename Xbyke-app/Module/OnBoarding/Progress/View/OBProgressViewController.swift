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
        
    }

    
}
