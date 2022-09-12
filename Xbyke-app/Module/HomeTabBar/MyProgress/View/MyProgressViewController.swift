//
//  MyProgressViewController.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit
import CoreData

class MyProgressViewController: UIViewController {
    var routes = [TrackerRouteModel]()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TrackerRouteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTrackedRoutes()
    }

    func loadTrackedRoutes() {
        let appleDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appleDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Track")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)

            routes = result.map { item -> TrackerRouteModel in
                let res = (item as? NSManagedObject)
                return TrackerRouteModel(distance: res?.value(forKey: "distance") as? String,
                                         endaddress: res?.value(forKey: "endaddress") as? String,
                                         startaddress: res?.value(forKey: "startaddress") as? String,
                                         time: res?.value(forKey: "time") as? String)
            }

            for route in routes {
                print("route \(route.distance)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }


        } catch {
            print("failed error load")
        }
    }

}

extension MyProgressViewController: UITableViewDelegate {

}

extension MyProgressViewController: UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //TODO: tthe view
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TrackerRouteTableViewCell
        cell?.configure(route: routes[indexPath.row])
        return cell!
    }



}
