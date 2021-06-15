//
//  Dynamic.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 14/06/21.
//

import Foundation

class Dynamic<T>: Codable where T: Codable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
    
}
