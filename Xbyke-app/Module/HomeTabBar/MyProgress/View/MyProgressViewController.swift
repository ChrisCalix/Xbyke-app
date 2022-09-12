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
    var viewModel: TrackerRouteViewModel = TrackerRouteViewModel()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TrackerRouteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewBind()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchGetData()
    }

    func initViewBind() {
        viewModel.response.bind { routes in
            guard let routes = routes else {
                return
            }
            self.routes = routes
            self.tableView.reloadData()
        }
    }

}

