//
//  CurrentRideViewModel.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit
import CoreData

class CurrentRideViewModel {
    var response: Observable<Bool> = Observable(false)

    func fetchSaveData(routeTracked: TrackerRouteModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Track", in: context)
        let newTrack = NSManagedObject(entity: entity!, insertInto: context)
        newTrack.setValue(routeTracked.distance, forKey: "distance")
        newTrack.setValue(routeTracked.time, forKey: "time")
        newTrack.setValue(routeTracked.endaddress, forKey: "endaddress")
        newTrack.setValue(routeTracked.startaddress, forKey: "startaddress")
        do {
            try context.save()
        } catch {
            print("error saving")
        }
        response.value = true
    }
}
