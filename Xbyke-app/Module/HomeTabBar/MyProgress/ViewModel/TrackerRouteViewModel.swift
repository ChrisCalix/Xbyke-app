//
//  TrackerRouteViewModel.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit
import CoreData

class TrackerRouteViewModel {
    var response: Observable<[TrackerRouteModel]> = Observable([TrackerRouteModel]())

    func fetchGetData() {
        let appleDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appleDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Track")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let routes = result.map { item -> TrackerRouteModel in
                let res = (item as? NSManagedObject)
                return TrackerRouteModel(distance: res?.value(forKey: "distance") as? String,
                                         endaddress: res?.value(forKey: "endaddress") as? String,
                                         startaddress: res?.value(forKey: "startaddress") as? String,
                                         time: res?.value(forKey: "time") as? String)
            }
            response.value = routes
        } catch {
            print("failed error load")
        }
    }
}
