//
//  Extensions.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//
import FirebaseFirestore
import Foundation
import SwiftUI
import CoreLocation

// JSON to dictionary encoder tool

extension Encodable {
    func encodeJSONToDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
            // ?? means otherwise
        } catch {
            return [:]
        }
    }
}

extension AppDelegate {
    
    func startSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

extension Int {
    init(_ range: Range<Int> ) {
        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
        let min = UInt32(range.startIndex + delta)
        let max = UInt32(range.endIndex   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}


