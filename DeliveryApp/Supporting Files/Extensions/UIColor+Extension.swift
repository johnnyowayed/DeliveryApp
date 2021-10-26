//
//  UIColor+Extension.swift
//  DeliveryApp
//
//  Created by Johnny on 26/10/2021.
//

import UIKit

extension UIColor {
    
    class var systemBlack:UIColor {
        return UIColor.init(named: "systemBlack") ?? .black
    }
    
    class var systemWhite:UIColor {
        return UIColor.init(named: "systemWhite") ?? .black
    }
    
    class var shadowColor: UIColor {
        return UIColor.init(named: "shadowColor") ?? .black
    }
}
