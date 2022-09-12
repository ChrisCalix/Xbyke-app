//
//  OBTrackerViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OBTrackerViewController: UIViewController {
    @IBOutlet weak var onBoarding: OnBoardingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        onBoarding.configureView(screen: .trackerDistanceTime, radius: (onBoarding.frame.width-30)/2)
    }

}
