//
//  CarViewModel.swift
//  JsonToMap
//
//  Created by André Niet on 26.10.17.
//  Copyright © 2017 André Niet. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias Result = (PlacemarkViewModel?, String) -> ()

struct PlacemarkViewModel: Codable {
    let placemarks: [Placemark]
}
struct Placemark: Codable {
    let address: String
    let coordinates: [Double]
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
}
