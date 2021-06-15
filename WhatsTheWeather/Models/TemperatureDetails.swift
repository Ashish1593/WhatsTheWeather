//
//  TemperatureDetails.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 15/06/21.
//

import Foundation

struct TemperatureDetails:Codable{
    let Value: Dynamic<Double>
    let Unit : Dynamic<String>
    let UnitType : Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Value =  Dynamic(try container.decode(Double.self, forKey: .Value))
        Unit =  Dynamic(try container.decode(String.self, forKey: .Unit))
        UnitType =  Dynamic(try container.decode(Double.self, forKey: .UnitType))
    }
    
    private enum CodingKeys:CodingKey {
        case Value
        case Unit
        case UnitType
    }
}
