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

class SearchViewController: UIViewController {
    
    @IBOutlet weak var txtFieldForSearch: BindingTextField! {
        didSet {
            txtFieldForSearch.bind {
                self.searchViewModel.city = $0
            }
        }
    }
    @IBOutlet weak var btnForSearch: UIButton!
    @IBOutlet weak var tableViewForRecentSearched: UITableView!
    
    private var searchViewModel = SearchViewModel()
    var delegate: searchWeatherDelegate?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.tableViewForRecentSearched.delegate = self
        self.tableViewForRecentSearched.dataSource = self
    }
    
    @IBAction func searchButtonPressed() {
        
        if let place = txtFieldForSearch.text {
            if let delegate = self.delegate {
                delegate.showWeather(place: place.replacingOccurrences(of: " ", with: ""))
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonString.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.searchViewModel.searchItemAtIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.searchViewModel.searchItemAtIndex(indexPath.row)
        if let delegate = self.delegate {
            delegate.showWeather(place: place.replacingOccurrences(of: " ", with: ""))
            self.dismiss(animated: true, completion: nil)
        }
    }
}
