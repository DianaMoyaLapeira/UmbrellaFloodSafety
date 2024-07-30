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
import FirebaseMessaging


@Observable
class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
 
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
            print("New Location for updating: \(newLocation)")
           // Call your Firebase manager function
           FirebaseManager.shared.updateLocation(newLocation: newLocation)
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



