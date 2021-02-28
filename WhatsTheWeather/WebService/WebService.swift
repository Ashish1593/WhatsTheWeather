//
//  WebService.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 28/02/21.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) ->()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
