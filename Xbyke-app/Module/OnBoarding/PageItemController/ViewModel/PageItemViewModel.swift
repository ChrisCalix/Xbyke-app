//
//  PageItemViewModel.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation

class PageItemViewModel {
    var screen : OnBoardingScreen?

    init(screen: OnBoardingScreen) {
        self.screen = screen
    }

    func descriptionFromScreen() -> String {
        return screen?.textDescription ?? ""
    }

    func iconFromScreen() -> String {
        return screen?.iconName ?? ""
    }

    func isHiddenButton() -> Bool {
        guard let screen = screen, screen != .progress else {
            return true
        }
        return false
    }
}
