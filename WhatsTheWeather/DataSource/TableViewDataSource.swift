//
//  TableViewDataSource.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 15/06/21.
//

import Foundation
import UIKit

class TableViewDataSource<ViewModel,CellType>:NSObject,UITableViewDataSource where CellType:UITableViewCell{
    
    let cellIdentifier:String
    let configureCell:(ViewModel,CellType,Int) -> ()
    let viewModel: Any
    
    init(cellIdentifier:String,viewModel: Any,configureCell: @escaping (ViewModel,CellType,Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel as! SearchViewModel).recentSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found")
        }
        
        self.configureCell(self.viewModel as! ViewModel ,cell,indexPath.row)
        return cell
        
    }
    
}
