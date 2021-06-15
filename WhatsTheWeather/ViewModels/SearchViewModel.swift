//
//  SearchViewModel.swift.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 01/03/21.
//

import Foundation

public class SearchViewModel {
    
    var city = ""
    let recentSearch = UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? [String]()
}

extension SearchViewModel {
    var  numberOfSection : Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return self.recentSearch.count
    }
    
    func searchItemAtIndex(_ index: Int) -> String {
        let searchItem = self.recentSearch[index]
        return searchItem
    }
}
