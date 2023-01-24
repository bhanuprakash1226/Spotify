//
//  Extensions.swift
//  SpotifyClone
//
//  Created by Damerla Bhanu Prakash on 24/01/23.
//

import Foundation
import UIKit

extension UITextField {
    func setupTextField(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    }
}
