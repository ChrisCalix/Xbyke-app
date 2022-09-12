//
//  OBPageItemTest+Helpers.swift
//  Xbyke-appTests
//
//  Created by Christian Calixto on 12/9/22.
//

@testable import Xbyke_app
import UIKit

extension OBPageItemTest {
    internal func makeSUT(with screen: OnBoardingScreen) -> PageItemController {
            let sut = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "PageItemController") as! PageItemController
            let mockViewModel = PageItemViewModel(screen: screen)
            sut.configure(viewModel: mockViewModel)
            sut.loadViewIfNeeded()
            return sut
    }
}
