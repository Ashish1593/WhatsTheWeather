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
    var dataSource: TableViewDataSource<SearchViewModel,UITableViewCell>?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        dataSource = TableViewDataSource(cellIdentifier:CommonString.cellIdentifier, viewModel: searchViewModel) {
            vm, cell, index in
            cell.textLabel?.text = vm.searchItemAtIndex(index)
        }
        self.tableViewForRecentSearched.delegate = self
        self.tableViewForRecentSearched.dataSource = dataSource
    }
    
    @IBAction func searchButtonPressed() {
        if let delegate = self.delegate {
            delegate.showWeather(place: searchViewModel.city.replacingOccurrences(of: " ", with: ""))
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.searchViewModel.searchItemAtIndex(indexPath.row)
        if let delegate = self.delegate {
            delegate.showWeather(place: place.replacingOccurrences(of: " ", with: ""))
            self.dismiss(animated: true, completion: nil)
        }
    }
}
