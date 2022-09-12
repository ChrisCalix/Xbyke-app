//
//  Enums.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation

enum OnBoardingScreen {
    case simpleToUse
    case trackerDistanceTime
    case progress

    var viewControllerName : String {
        switch self {
        case .simpleToUse:
            return String(describing: OBUseViewController.self)
        case .trackerDistanceTime:
            return String(describing: OBTrackerViewController.self)
        case .progress:
            return String(describing: OBProgressViewController.self)
        }
    }


}

enum PaginationFlowTypes {
    case before
    case after
}
