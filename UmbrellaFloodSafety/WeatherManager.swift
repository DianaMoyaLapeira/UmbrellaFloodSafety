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
    var alerts: [WeatherAlert] = []
    var floodWarnings: [WeatherAlert] = []
    var floodAdvisories: [WeatherAlert] = []
    var floodWatches: [WeatherAlert] = []
    
    func getWeather(coordinate: CLLocationCoordinate2D) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) { [weak self] in
                return try await self?.weatherService.weather(for: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
            }.value
            
            self.alerts = fetchWeatherAlerts()
            
            getFloodWarnings()
            
        } catch {
            print("Failed to get weather data. \(error)")
        }
    }
    
    func fetchWeatherAlerts() -> [WeatherAlert] {
        
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
    
    func getFloodWarnings() {
        
        var warnings: [WeatherAlert] = []
        
        let potentiallyWarningAlerts = self.alerts
        
        for alert in potentiallyWarningAlerts {
            if alert.summary.lowercased().contains("warning") {
                warnings.append(alert)
            }
        }
        
        floodWarnings = warnings
        
        getFloodAdvisories()
    }
    
    func getFloodAdvisories() {
        
        var warnings: [WeatherAlert] = []
        
        let potentialFloodAdvisories = self.alerts
        
        for alert in potentialFloodAdvisories {
            if alert.summary.lowercased().contains("advisory") {
                warnings.append(alert)
            }
        }
        
        floodAdvisories = warnings
        getFloodWatches()
    }
    
    func getFloodWatches() {
        
        var warnings: [WeatherAlert] = []
        
        let potentialFloodWatches = self.alerts
        
        for alert in potentialFloodWatches {
            if alert.summary.lowercased().contains("watch") {
                warnings.append(alert)
            }
        }
        
        floodWarnings = warnings
        
    }
    
    func getRiskLevel(coordinate: CLLocationCoordinate2D) async -> Int {
        guard coordinate.latitude != 0 && coordinate.longitude != 0 else { return 3 }
        
        await getWeather(coordinate: coordinate)
        
        if floodWarnings != [] {
            return 2
        } else if (floodAdvisories != []) || (floodWatches != []) {
            return 1
        } else {
            return 0
        }
    }
}
