//
//  UmbrellaFloodSafetyApp.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI
import CoreLocation

@Observable
class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate {
 
    var location: CLLocation = CLLocation(latitude: 37.3346, longitude: 122.0090)
    let locationManager = CLLocationManager()
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Umbrella application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
        FirebaseApp.configure()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        // Remember to request to always authorization by going into settings
        return true
    }
}

@main
struct UmbrellaFloodSafetyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}



