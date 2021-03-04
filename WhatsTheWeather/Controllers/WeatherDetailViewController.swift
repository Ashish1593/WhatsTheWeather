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
    @IBOutlet weak var serachUiTextField: UITextField!
    @IBOutlet weak var locationPressed: UIButton!
    
    let locationManager = CLLocationManager()

    private var weatherDetailViewModel = WeatherDetailViewModel()
    
    let apikey: String = "scaqcbTq6CvGvHCrWD6A1xDGJCngbA9J"
    let location : String = "Nagpur"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        self.fetchWeather(locationKey: "204844")
    }
    
    @IBAction func locationPressedOnCLick(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    func fetchLocation(locationKey:String) {
        let weatherURL = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/\(locationKey)?apikey=\(apikey)")!
        
        let weatherResource = Resource<Weather>(url: weatherURL) { data in
            
            let weatherVM = try? JSONDecoder().decode(Weather.self, from: data)
            return weatherVM
        }
        
        WebService().load(resource: weatherResource) { [weak self] result in
            
            if let weatherVM = result {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
 
    func fetchWeather(locationKey:String) {
        let weatherURL = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/\(locationKey)?apikey=\(apikey)")!
        
        let weatherResource = Resource<Weather>(url: weatherURL) { data in
            
            let weatherVM = try? JSONDecoder().decode(Weather.self, from: data)
            return weatherVM
        }
        
        WebService().load(resource: weatherResource) { [weak self] result in
            
            if let weatherVM = result {
                self?.dismiss(animated: true, completion: nil)
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
