//
//  AppDelegate.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 9/17/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreLocation


@Observable
class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
 
    let locationManager = CLLocationManager()
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Umbrella application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
        FirebaseApp.configure()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("Location services neabled")
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.pausesLocationUpdatesAutomatically = false

        }
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            guard granted else { return }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
           }
        }
        UNUserNotificationCenter.current().setBadgeCount(0)
        
        if (locationManager.location != nil) {
            FirebaseManager.shared.updateLocation(newLocation: locationManager.location ?? CLLocation(latitude: 0, longitude: 0)) { error in
                if error {
                    print("An error occured updating location", error)
                }
            }
        }
        // Remember to request to always authorization by going into settings
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("location manager failed with error", error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        // Call Firebase manager function and end task when location updates
        FirebaseManager.shared.updateLocation(newLocation: newLocation) { error in
            if error {
                print("an error occurred \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        
        FirebaseManager.shared.updateDeviceToken(DeviceToken: deviceTokenString)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        var task: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
        
        task = application.beginBackgroundTask(expirationHandler: {
            application.endBackgroundTask(task)
            task = UIBackgroundTaskIdentifier.invalid
        })
        
        FirebaseManager.shared.updateLocation(newLocation: locationManager.location ?? CLLocation(latitude: 0, longitude: 0)) { success in
            application.endBackgroundTask(task)
            task = UIBackgroundTaskIdentifier.invalid
        }
       
    }
    
}
