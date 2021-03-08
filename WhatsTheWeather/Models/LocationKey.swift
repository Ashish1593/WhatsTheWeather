//
//  LocationKey.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 07/03/21.
//

import Foundation

struct LocationKey: Codable {
    let Key: String
}

extension LocationKey {
    static let defaultLocation = "Nagpur"
    static let defaultLat = 28.643
    static let defaultLon = 77.118
}
