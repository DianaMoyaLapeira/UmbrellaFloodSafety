//
//  WarningColorManager.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import SwiftUI
import Foundation

@Observable
class WarningColorManager: WeatherManager {
    
    func WarningColor() -> Color {
        if (!floodWarnings.isEmpty) {
            return Color.red
        } else if (!floodAdvisories.isEmpty || !floodWatches.isEmpty) {
            return Color.accentYellow
        } else {
            return Color.accentGreen
        }
    }
}
