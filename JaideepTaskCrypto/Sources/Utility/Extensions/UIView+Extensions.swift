//
//  UIView+Extensions.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import UIKit

extension UIView {
    func addBorder(width: CGFloat = 1, color: UIColor = UIColor.gray) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func roundedCorners(withRadius radius: CGFloat = 10) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}
