//
//  CarTableViewCell.swift
//  JsonToMap
//
//  Created by André Niet on 26.10.17.
//  Copyright © 2017 André Niet. All rights reserved.
//

import UIKit

class PlacemarkTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var engineType: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var interior: UILabel!
    @IBOutlet weak var exterior: UILabel!
    var coordinates: [Double]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withData data: Placemark) {
        name.text = data.name
        address.text = "Address: " + data.address
        engineType.text = "Engine Type: " + data.engineType
        fuel.text = "Fuel: " + String(data.fuel)
        vin.text = "Vin" + data.vin
        interior.text = "Interior: " + data.interior
        exterior.text = "Exterior: " + data.exterior
        coordinates = data.coordinates
    }

}
