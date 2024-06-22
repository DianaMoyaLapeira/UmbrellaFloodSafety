//
//  Extensions.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import Foundation
import SwiftUI

// Colors

extension UIColor {
    class var MainBlue: UIColor {
        guard let color = UIColor(named: "mainBlue") else { return .blue }
        return color
    }
    
    class var AccentYellow: UIColor {
        guard let color = UIColor(named: "accentYellow") else { return .yellow }
        return color
    }
    
    class var AccentGreen: UIColor {
        guard let color = UIColor(named: "accentGreen") else { return .green }
        return color
    }
    
    class var SkyBlue: UIColor {
        guard let color = UIColor(named: "skyBlue") else { return .blue}
        return color
    }
}

