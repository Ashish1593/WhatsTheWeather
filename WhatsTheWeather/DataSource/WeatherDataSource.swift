//
//  WeatherDataSource.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 15/06/21.
//

import Foundation
import UIKit

class WetherDataSource : NSObject,UITableViewDataSource {
    
    let cellIdentifier =  CommonString.cellIdentifier
    private var searchViewModel: SearchViewModel
    
    init(_ searchViewModel:SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)
        
        cell.textLabel?.text = self.searchViewModel.searchItemAtIndex(indexPath.row)
        return cell
    }
}
