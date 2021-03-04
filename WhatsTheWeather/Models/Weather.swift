//
//  Weather.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 01/03/21.
//

import Foundation


struct Weather:Codable {
    let WeatherText: String
    let EpochTime: Int64
    let Temperature: Temperature
}

struct Temperature:Codable {
    let Metric: TemperatureDetails
    let Imperial: TemperatureDetails
}

struct TemperatureDetails:Codable{
    let Value: Double
    let Unit : String
    let UnitType : Double
}

