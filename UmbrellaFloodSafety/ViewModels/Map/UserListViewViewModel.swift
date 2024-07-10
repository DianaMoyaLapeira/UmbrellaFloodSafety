//
//  UserListViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 1/7/24.
//

import FirebaseFirestore
import Foundation
import CoreLocation

class UserListViewViewModel: ObservableObject {
    
    var firebaseManager = FirebaseManager.shared
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 9.940158, longitude: -84.144093)
    var groupId: String = ""
    var username: String = ""
    @Published var address: String = "Retrieving address..."
    @Published var name: String = ""
    
    init(groupId: String, username: String) {
        self.username = username
        self.groupId = groupId
        getName()
        getLocation(username: username)
    }
    
    func getLocation(username: String) {
        self.userLocation = firebaseManager.groupMembersLocations[username] ?? CLLocationCoordinate2D(latitude: 9.940158, longitude: -84.144093)
        print(self.userLocation)
        lookUpAddress(location: self.userLocation)
    }
    
    private let geocoder = CLGeocoder()
    
    func getName() -> Void {
        
        let db = Firestore.firestore()
        
        let _: Void = db.collection("users").document("\(username)").getDocument { (document, error) in
            if let document = document {
                let name = document.data()?["name"] as? String
                self.name = name ?? "No username"
            }
        }
    }
    
    func lookUpAddress(location: CLLocationCoordinate2D) {
        
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error)")
                DispatchQueue.main.async {
                    self?.address = "Failed to retrieve address."
                }
                return
            }
            
            if let placemark = placemarks?.first {
                let address = "Near \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                DispatchQueue.main.async {
                    self?.address = address
                }
            } else {
                DispatchQueue.main.async {
                    self?.address = "No address found."
                }
            }
        }
    }
}
