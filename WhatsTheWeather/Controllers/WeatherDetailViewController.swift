//
//  WeatherDetailViewController.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 01/03/21.
//

import Foundation
import UIKit
import CoreLocation


class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationPressed: UIButton!
    @IBOutlet weak var searchPressed: UIButton!
    
    let locationManager = CLLocationManager()
    
    private var weatherDetailViewModel = WeatherDetailViewModel()
    
    let apikey: String = "scaqcbTq6CvGvHCrWD6A1xDGJCngbA9J"
    let location : String = "Nagpur"
    let latitude = 28.643
    let longitude = 77.118
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
//        self.getLocationKey1(location: "Delhi")
                        self.getLocationKey(lat: latitude, long: longitude)
        //        self.fetchWeather(locationKey: "204844")
    }
    
    @IBAction func locationPressedOnCLick(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    @IBAction func searchPressedOnCLick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "openSearchViewController", sender: self)
    }
    
    func fetchWeather(locationKey:String) {
        
        let weatherResource: Resource<[Weather]> = {
            
            guard let url = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/\(locationKey)?apikey=\(apikey)&details=false") else {
                fatalError("URL is incorrect!")
            }
            
            return Resource<[Weather]>(url: url)
            
        }()
        
        WebService().load(resource: weatherResource) { [weak self] result in
            
            switch result {
            case .success(let weather):
                print("weather fetched")
                self?.weatherDetailViewModel.weather = weather[0]
                self?.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI() {
        self.temperatureLabel.text = String(weatherDetailViewModel.metricValue)
        self.cityLabel.text = weatherDetailViewModel.weatherText
        self.timeLabel.text = weatherDetailViewModel.time
    }
    
    
    func getLocationKey(lat:Double,long:Double) {
        
        let locationUrl: Resource<LocationKey> = {
            guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(apikey)&q=\(lat)%2C\(long)") else {
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
            }
        }
    }
    
    func getLocationKey1(location:String) {
        
        
        let locationUrl: Resource<[LocationKey]> = {
            guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=\(apikey)&q=\(location)") else {
                fatalError("URL is incorrect!")
            }
            return Resource<[LocationKey]>(url: url)
        }()
        
        WebService().load(resource: locationUrl) { [weak self] result in
            
            switch result {
            case .success(let locationKey):
                self?.fetchWeather(locationKey: locationKey[0].Key)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- CLLocationManagerDelegate
extension WeatherDetailViewController : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.getLocationKey(lat: lat, long: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
