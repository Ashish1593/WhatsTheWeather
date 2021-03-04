//
//  WeatherDetailViewModel.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 28/02/21.
//

import Foundation
import CoreLocation


public class WeatherDetailViewModel {
    
    private let weather: Weather! = nil
    
}

extension WeatherDetailViewModel {
    var weatherText: String {
        return self.weather.WeatherText
    }
    
    var time: Date {
        let epochTime = TimeInterval(self.weather.EpochTime)
        let date = Date(timeIntervalSince1970: epochTime)   // "Apr 16, 2015, 2:40 AM"
        
        return date
    }
    
    var imperialValue: Double {
        return weather.Temperature.Imperial.Value
    }
    
    var metricValue: Double {
        return weather.Temperature.Metric.Value
    }
    
    var imperialUnit: String {
        return weather.Temperature.Imperial.Unit
    }
    
    var imperialUnitType: Double {
        return weather.Temperature.Imperial.UnitType
    }
    
    var metricUnit: String {
        return weather.Temperature.Metric.Unit
    }
    
    var metricUnitType: Double {
        return weather.Temperature.Metric.UnitType
    }
}
