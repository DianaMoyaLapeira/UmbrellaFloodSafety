//
//  WeatherManager.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 26/6/24.
//

// Remember to do attribution for weather
import CoreLocation
import Foundation
import WeatherKit
import SwiftUI

@Observable 
class WeatherManager {
    
    private let weatherService = WeatherService()
    var weather: Weather?
    
    func getWeather(lat: Double, long: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) { [weak self] in
                return try await self?.weatherService.weather(for: .init(latitude: lat, longitude: long))
            }.value
        } catch {
            print("Failed to get weather data. \(error)")
        }
    }
    
    var fetchWeatherAlerts: [WeatherAlert] {
        
        var floodAlerts: [WeatherAlert] = []
        
        do {
            guard let alerts = weather?.weatherAlerts else {return []}
                for alert in alerts {
                if alert.summary.lowercased().contains("flood") {
                    floodAlerts.append(alert)
                }
            }
        }
        
        return floodAlerts
    }
    
    var floodWarnings: [WeatherAlert] {
        
        var warnings: [WeatherAlert] = []
        
        var potentiallyWarningAlerts = self.fetchWeatherAlerts
        
        for alert in potentiallyWarningAlerts {
            if alert.summary.lowercased().contains("warning") {
                warnings.append(alert)
            }
        }
        
        return warnings
        
    }
    
    var floodAdvisories: [WeatherAlert] {
        
        var warnings: [WeatherAlert] = []
        
        var potentialFloodAdvisories = self.fetchWeatherAlerts
        
        for alert in potentialFloodAdvisories {
            if alert.summary.lowercased().contains("advisory") {
                warnings.append(alert)
            }
        }
        
        return warnings
        
    }
    
    var floodWatches: [WeatherAlert] {
        
        var warnings: [WeatherAlert] = []
        
        var potentialFloodWatches = self.fetchWeatherAlerts
        
        for alert in potentialFloodWatches {
            if alert.summary.lowercased().contains("advisory") {
                warnings.append(alert)
            }
        }
        
        return warnings
        
    }
    
}
