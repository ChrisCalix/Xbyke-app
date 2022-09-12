//
//  OBUseViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OBUseViewController: UIViewController {
    @IBOutlet weak var onBoarding: OnBoardingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        onBoarding.configureView(screen: .simpleToUse, radius: (onBoarding.frame.width-30)/2)
    }

}
