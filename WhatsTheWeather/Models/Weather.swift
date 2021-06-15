//
//  Weather.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 01/03/21.
//

import Foundation

struct Weather:Codable {
    
    let WeatherText: Dynamic<String>
    let EpochTime: Dynamic<Int64>
    let Temperature: TemperatureType
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        WeatherText = Dynamic(try container.decode(String.self, forKey: .WeatherText))
        EpochTime = Dynamic(try container.decode(Int64.self, forKey: .EpochTime))
        Temperature = try container.decode(TemperatureType.self,forKey: .Temperature)
    }
    
    private enum CodingKeys: CodingKey {
        case WeatherText
        case EpochTime
        case Temperature
    }
    
}


