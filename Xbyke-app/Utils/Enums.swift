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

    var viewControllerName: String {
        switch self {
        case .simpleToUse:
            return String(describing: OBUseViewController.self)
        case .trackerDistanceTime:
            return String(describing: OBTrackerViewController.self)
        case .progress:
            return String(describing: OBProgressViewController.self)
        }
    }

    var textDescription: String {
        switch self {
        case .simpleToUse:
            return "Extremely simple to use"
        case .trackerDistanceTime:
            return "Track your time and distance"
        case .progress:
            return "See your progress and challenge yourself!"
        }
    }

    var iconName: String {
        switch self {
        case .simpleToUse:
            return "track"
        case .trackerDistanceTime:
            return "distance"
        case .progress:
            return "progress"
        }
    }
}

enum PaginationFlowTypes {
    case before
    case after
}
