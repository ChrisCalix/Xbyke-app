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

    init?(frame:CGRect, screen: OnBoardingScreen) {
        super.init(frame: frame)
        configureView(screen: screen, radius: frame.width/2)
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
        text.text = screen.textDescription
        icon.image = UIImage(named: screen.iconName)
        backgroundIcon.layer.cornerRadius = radius
        backgroundIcon.clipsToBounds = true
    }
}
