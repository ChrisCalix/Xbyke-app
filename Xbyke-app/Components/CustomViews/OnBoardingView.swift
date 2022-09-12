//
//  OnBoardingView.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class OnBoardingView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var backgroundIcon: UIView!
    @IBOutlet weak var text: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init?(coder: NSCoder, screen: OnBoardingScreen) {
        super.init(coder: coder)
        configureView(screen: screen, radius: UIScreen.main.bounds.width)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        view = self.loadOnBoardingViewFromNib(nibName: "OnBoardingView")
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = self.bounds
        self.addSubview(view)
    }

    func configureView(screen: OnBoardingScreen, radius: CGFloat) {
        switch screen {
        case .simpleToUse:
            icon.image = UIImage(named: "track")
            text.text = "Extremely simple to use"
        case .trackerDistanceTime:
            icon.image = UIImage(named: "distance")
            text.text = "Track your time and distance"
        case .progress:
            icon.image = UIImage(named: "progress")
            text.text = "See your progress and challenge yourself!"
        }
        backgroundIcon.layer.cornerRadius = radius
        backgroundIcon.clipsToBounds = true
    }
}
