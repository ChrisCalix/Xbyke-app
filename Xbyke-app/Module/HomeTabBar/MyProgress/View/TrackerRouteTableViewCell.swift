//
//  TrackerRouteTableViewCell.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import UIKit

class TrackerRouteTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startAddress: UILabel!
    @IBOutlet weak var endAddress: UILabel!

    var route: TrackerRouteModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    func configure(route: TrackerRouteModel) {
        distanceLabel.text = route.distance ?? ""
        timeLabel.text = route.time ?? ""
        self.startAddress.text = route.startaddress ?? ""
        self.endAddress.text = route.endaddress ?? ""
        setNeedsLayout()
    }
}
