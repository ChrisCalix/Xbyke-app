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

    func configureView(description: String?, iconName: String?, radius: CGFloat) {
        backgroundIcon.layer.cornerRadius = radius
        backgroundIcon.clipsToBounds = true
        text.text = description
        guard let iconName = iconName else {
            return
        }
        icon.image = UIImage(named: iconName)
    }
}
