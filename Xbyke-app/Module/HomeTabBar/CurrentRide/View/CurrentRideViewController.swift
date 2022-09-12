//
//  CurrentRideViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit
import GoogleMaps
import CoreData


class CurrentRideViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager: CLLocationManager!
    @IBOutlet weak var timeLabel: UILabel!
    var currentLocations : [CLLocation] = []
    var lastLocation : CLLocation?
    var distanceAccum : Double = 0
    @IBOutlet weak var distanceLabel: UILabel!

    @IBOutlet weak var timeStoreLabel: UILabel!
    @IBOutlet weak var storeCard: UIView! {
        didSet {
            storeCard.layer.cornerRadius = 25
            storeCard.layer.shadowRadius = 1
            storeCard.layer.shadowOpacity = 0.3
            storeCard.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
    @IBOutlet weak var confirmationView: UIView!
    @IBOutlet weak var storeStack: UIStackView!

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
    let paths = GMSMutablePath()
    var timeStart : Date?
    var presstrackRoute = false
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

    var tracksPath = [Track]()
    var viewModel: CurrentRideViewModel? = CurrentRideViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewBind()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrackerCard))
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.mapView.isMyLocationEnabled = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocatoinAuthorizationStatus(from: locationManager, started: false)
    }

    func initViewBind() {
        viewModel?.response.bind({ state in
            DispatchQueue.main.async {
                self.storeStack.isHidden = true
                self.confirmationView.isHidden = false
            }

        })
    }

    @objc func addTrackerCard() {
        if timerCard.isHidden {
            timerCard.isHidden = false
            timeLabel.text = "00:00:00"
            timeStoreLabel.text = "00:00:00"
        }
    }

    func runTimer() {

         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CurrentRideViewController.updateTimer)), userInfo: nil, repeats: true)
    }


    @objc func updateTimer() {
        seconds += 1
        timeLabel.text = timeString(time: TimeInterval(seconds))
        timeStoreLabel.text = timeString(time: TimeInterval(seconds))
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
            timerCard.isHidden = true
            storeCard.isHidden = false
            if distanceAccum >= 1000 {
                distanceLabel.text = String(format: "%. 2f", distanceAccum/1000) + " km."
            } else {
                distanceLabel.text = String(format: "%. 2f", distanceAccum) + " m."
            }

        }
    }

    @IBAction func didPressedStore(_ sender: Any) {
        getAddressFromLatLon(location: currentLocations.first!) { addresFirst in
            self.getAddressFromLatLon(location: self.currentLocations.last!) { adressLast in
                let routetrack = TrackerRouteModel(distance: self.distanceLabel.text,
                                                   endaddress: adressLast,
                                                   startaddress: addresFirst,
                                                   time: self.timeStoreLabel.text)
                self.viewModel?.fetchSaveData(routeTracked: routetrack)
            }
        }

    }

    

    @IBAction func didPressedDelete(_ sender: Any) {
        mapView.clear()
        paths.removeAllCoordinates()
        seconds = 0
        storeCard.isHidden = true
    }

    @IBAction func didPressedStoreOk(_ sender: Any) {
        mapView.clear()
        paths.removeAllCoordinates()
        seconds = 0
        storeCard.isHidden = true
        storeStack.isHidden = false
        confirmationView.isHidden = true
    }

    func getAddressFromLatLon(location: CLLocation, completion: @escaping (String) -> Void) {

        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
            guard error == nil else {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                completion("")
                return
            }
            let pm = placemarks! as [CLPlacemark]
            var addressString : String = ""
            if pm.count > 0 {
                let pm = placemarks!.first!

                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                completion(addressString)
          }
        })
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
