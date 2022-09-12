//
//  CurrentRideViewController+LocationDelegate.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import CoreLocation
import Foundation
import GoogleMaps

extension CurrentRideViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print("present location : \(location.coordinate.latitude), \(location.coordinate.longitude)")
            mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17.0)

            if presstrackRoute {
                currentLocations.append(location)
                paths.add(location.coordinate)

                if let lastLocation = lastLocation {
                    distanceAccum += location.distance(from: lastLocation)
                }
                lastLocation = location

            }
            let polyline = GMSPolyline(path: paths)
            polyline.strokeColor = .red
            polyline.strokeWidth = 5
            polyline.map =  presstrackRoute ? mapView : nil
        }
    }
}
