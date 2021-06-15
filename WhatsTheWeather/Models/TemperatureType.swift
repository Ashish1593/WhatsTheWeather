//
//  TemperatureType.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 15/06/21.
//

import Foundation
struct TemperatureType:Codable {
    let Metric: TemperatureDetails
    let Imperial: TemperatureDetails
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Metric = try container.decode(TemperatureDetails.self, forKey: .Metric)
        Imperial = try container.decode(TemperatureDetails.self, forKey: .Imperial)
    }

    private enum CodingKeys: CodingKey {
        case Metric
        case Imperial
    }
}
