//
//  SearchViewController.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 01/03/21.
//

import Foundation
import UIKit

protocol searchWeatherDelegate {
    func showWeather(place:String)
}

class SearchViewController : UIViewController {
    
    @IBOutlet weak var txtFieldForSearch: UITextField!
    @IBOutlet weak var btnForSearch: UIButton!
    @IBOutlet weak var tableViewForRecentSearched: UITableView!
    
    var delegate: searchWeatherDelegate?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    
    @IBAction func searchButtonPressed() {
        
        if let place = txtFieldForSearch.text {
            if let delegate = self.delegate {
                delegate.showWeather(place: place)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
