//
//  WeatherDetailViewModel.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 28/02/21.
//

import Foundation
import CoreLocation


protocol UpdateUIDelegate {
    func updateUI()
    func showErrorMessage(_ errorMessage: String)
}

public class WeatherDetailViewModel {
    var weather: Weather! = nil
    var delegate: UpdateUIDelegate?
}

extension WeatherDetailViewModel {
    var weatherText: String {
        return self.weather.WeatherText
    }
    
    var time: String {
        let epochTime = TimeInterval(self.weather.EpochTime)
        let date = Date(timeIntervalSince1970: epochTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d"
        return dateFormatter.string(from: date)
    }

    var metricValue: Double {
        return weather.Temperature.Metric.Value
    }
    
}


extension WeatherDetailViewModel {
    
    func fetchWeather(locationKey:String) {
        
        let weatherResource: Resource<[Weather]> = {
            
            guard let url = URL(string: "\(CommonString.baseUrl)/currentconditions/v1/\(locationKey)?apikey=\(CommonString.apiKey)&details=false") else {
                fatalError("URL is incorrect!")
            }
            
            return Resource<[Weather]>(url: url)
            
        }()
        
        WebService().load(resource: weatherResource) { [weak self] result in
            
            switch result {
            case .success(let weather):
                print("weather fetched")
                self?.weather = weather[0]
                self?.delegate?.updateUI()
            case .failure(let error):
                print(error)
                self?.delegate?.showErrorMessage("No weather Found")
            }
        }
    }
    
    func getLocationKey(searchLocation:String) {
        
        
        let locationUrl: Resource<[LocationKey]> = {
            guard let url = URL(string: "\(CommonString.baseUrl)/locations/v1/cities/search?apikey=\(CommonString.apiKey)&q=\(searchLocation)") else {
                fatalError("URL is incorrect!")
            }
            return Resource<[LocationKey]>(url: url)
        }()
        
        WebService().load(resource: locationUrl) { [weak self] result in
            
            switch result {
            case .success(let location):
                if location.count > 0 {
                    
                    var myarray = [String]()
                    myarray = UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? [String]()
                    myarray.insert(searchLocation, at: 0)
                    UserDefaults.standard.set(myarray, forKey: "RecentSearches")
                    
                    self?.fetchWeather(locationKey: location[0].Key)
                } else {
                    self?.delegate?.showErrorMessage("No Match Found")
                }
            case .failure(let error):
                print(error)
                self?.delegate?.showErrorMessage("Something went wrong")
            }
        }
    }
    
    func getLocationKey(lat:Double,long:Double) {
        
        let locationUrl: Resource<LocationKey> = {
            guard let url = URL(string: "\(CommonString.baseUrl)/locations/v1/cities/geoposition/search?apikey=\(CommonString.apiKey)&q=\(lat)%2C\(long)") else {
                fatalError("URL is incorrect!")
            }
            
            return Resource<LocationKey>(url: url)
            
        }()
        
        WebService().load(resource: locationUrl) { [weak self] result in
            
            switch result {
            case .success(let locationKey):
                self?.fetchWeather(locationKey: locationKey.Key)
            case .failure(let error):
                print(error)
                self?.delegate?.showErrorMessage("Something went wrong")
            }
        }
    }
}
