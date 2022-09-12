//
//  CurrentRideViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit
import GoogleMaps

class CurrentRideViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager: CLLocationManager!
    @IBOutlet weak var timeLabel: UILabel!
    var currentLocations : [CLLocation] = []
    @IBOutlet weak var timerCard: UIView! {
        didSet {
            timerCard.layer.cornerRadius = 25
            timerCard.layer.shadowRadius = 1
            timerCard.layer.shadowOpacity = 0.3
            timerCard.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    let path = GMSMutablePath()
    var timeStart : Date?
    var presstrackRoute = false
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrackerCard))


        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.mapView.isMyLocationEnabled = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocatoinAuthorizationStatus(from: locationManager, started: false)
    }


    @objc func addTrackerCard() {
        if timerCard.isHidden {
            timerCard.isHidden = false
            timeLabel.text = "00:00:00"
        }
    }



    func runTimer() {
        mapView.clear()

        seconds = 0
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CurrentRideViewController.updateTimer)), userInfo: nil, repeats: true)
    }


    @objc func updateTimer() {
        seconds += 1
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }

    @IBAction func didPressedStart(_ sender: Any) {
        checkLocatoinAuthorizationStatus(from: locationManager, started: true)
    }

    @IBAction func didPressedStop(_ sender: Any) {
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
        if presstrackRoute {
            presstrackRoute = false
            timer.invalidate()
            path.removeAllCoordinates()
        }
    }

    func checkLocatoinAuthorizationStatus(from manager: CLLocationManager, started: Bool) {
        switch manager.authorizationStatus {
        case .notDetermined, .denied, .restricted :
            manager.requestAlwaysAuthorization()
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            if started {
                presstrackRoute = true
                runTimer()
            }
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()

        default:
            break
        }
    }

    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

extension CurrentRideViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print("present location : \(location.coordinate.latitude), \(location.coordinate.longitude)")
            mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17.0)

            if presstrackRoute {
                path.add(location.coordinate)

            }
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = .red
            polyline.strokeWidth = 5
            polyline.map =  presstrackRoute ? mapView : nil
        }
    }
}
