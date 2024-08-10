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
class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
 
    var location: CLLocation = CLLocation(latitude: 37.3346, longitude: 122.0090)
    let locationManager = CLLocationManager()
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Umbrella application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
        FirebaseApp.configure()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Notification permission granted: \(granted)")
            
            guard granted else { return }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
           }
        }
        
        // Remember to request to always authorization by going into settings
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "LocationUpdate") {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    
        print("New Location for updating: \(newLocation)")
        // Call Firebase manager function and end task when location updates
        FirebaseManager.shared.updateLocation(newLocation: newLocation) { success in
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        print(deviceTokenString)
        
        FirebaseManager.shared.updateDeviceToken(DeviceToken: deviceTokenString)
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



