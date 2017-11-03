//
//  CarDataSource.swift
//  JsonToMap
//
//  Created by André Niet on 26.10.17.
//  Copyright © 2017 André Niet. All rights reserved.
//

import Foundation
import UIKit

class PlacemarksDataSource: NSObject, UITableViewDataSource {
    lazy var dataProvider: PlacemarksDataProvider = {
        let dataprovider = PlacemarksDataProvider()
        return dataprovider
    }()
    
    var placemarks: [Placemark]?
    
    func refreshData(for tableView: UITableView?) {
        DispatchQueue.main.async {
            self.dataProvider.requestData() { [weak self] (carViewModel: PlacemarkViewModel?, errorMessage: String) in
                guard let carViewModel = carViewModel else {
                    print(errorMessage)
                    return
                }
                
                self?.placemarks = carViewModel.placemarks
                tableView?.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let placemarks = placemarks {
            return placemarks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier = "CarCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as? PlacemarkTableViewCell
            else {
                return UITableViewCell.init(style: .default, reuseIdentifier: "defaultUIKitCell")
        }
        if let data = self.placemarks?[indexPath.row] {
            cell.configure(withData: data)
        }
                
        return cell
    }
}


