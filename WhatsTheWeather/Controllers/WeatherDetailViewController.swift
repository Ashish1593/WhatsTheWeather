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
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationPressed: UIButton!
    @IBOutlet weak var searchPressed: UIButton!
    
    let locationManager = CLLocationManager()
    
    private var weatherDetailViewModel = WeatherDetailViewModel()
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        weatherDetailViewModel.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let searchVC = segue.destination as? SearchViewController else {
            fatalError("Controller not found")
        }
        searchVC.delegate = self
    }
    
    @IBAction func locationPressedOnCLick(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressedOnCLick(_ sender: UIButton) {
        self.performSegue(withIdentifier: CommonString.weatherScreenSegue, sender: self)
    }
    
    func updateUIDetails() {
        if let weather = self.weatherDetailViewModel.weather {
            weather.WeatherText.bind { self.weatherLabel.text = $0 }
            weather.Temperature.Metric.Value.bind { self.temperatureLabel.text = String($0)}
            weather.EpochTime.bind {
                self.timeLabel.text = self.weatherDetailViewModel.timeFormat(time: $0)
            }
//            weather.Place.bind { self.cityLabel.text = $0 }
        }
    }
}

//MARK:- searchWeatherDelegate
extension WeatherDetailViewController:searchWeatherDelegate {
    func showWeather(place:String) {
        weatherDetailViewModel.getLocationKey(searchLocation: place)
    }
}

//MARK:- searchWeatherDelegate
extension WeatherDetailViewController: UpdateUIDelegate {
    
    func updateUI() {
        self.updateUIDetails()
    }
    
    func showErrorMessage(_ errorMessage: String){
        self.showToast(message: errorMessage)
    }
}

//MARK:- CLLocationManagerDelegate
extension WeatherDetailViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = Double(String(format: "%.3f", location.coordinate.latitude))!
            let lon = Double(String(format: "%.3f", location.coordinate.longitude))!
            weatherDetailViewModel.getLocationKey(lat: lat, long: lon)
        } else {
            weatherDetailViewModel.getLocationKey(lat: LocationKey.defaultLat, long: LocationKey.defaultLon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        weatherDetailViewModel.getLocationKey(lat: LocationKey.defaultLat, long: LocationKey.defaultLon)
    }
}
