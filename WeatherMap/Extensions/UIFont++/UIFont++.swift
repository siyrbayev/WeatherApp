//
//  UIFont++.swift
//  WeatherMap
//
//  Created by Nurym Siyrbayev on 02.12.2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func ubuntu(_ size: CGFloat,_ weight: UIFont.Weight = .regular) -> UIFont {
        
        var weigth: String {
            switch weight {
            case .bold:
                return "Ubuntu-Bold"
            case .medium:
                return "Ubuntu-Medium"
            case .regular:
                return "Ubuntu-Regular"
            case .light:
                return "Ubuntu-Light"
            default:
                return "Ubuntu-Regular"
            }
            
        }
        return UIFont(name: weigth, size: size) ?? UIFont.systemFont(ofSize: size)
        
    }
}

