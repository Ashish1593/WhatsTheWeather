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
    static let defaultLat = 21.145
    static let defaultLon = 79.088
}
