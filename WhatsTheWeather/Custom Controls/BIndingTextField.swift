//
//  BIndingTextField.swift
//  WhatsTheWeather
//
//  Created by Ashish Yadav on 07/06/21.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    var textChangeClosure:(String) -> () = {_ in}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    func bind(callback: @escaping (String) -> () ) {
        self.textChangeClosure = callback
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        if let text = textField.text {
            self.textChangeClosure(text)
        }
    }
}
