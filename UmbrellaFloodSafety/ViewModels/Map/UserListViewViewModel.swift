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
        print("Look up address function called")
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            
            if let error = error {
                print("Reverse geocoding failed with error: \(error)")
                DispatchQueue.main.async {
                    self?.address = "Address unavailable :("
                    return
                }
            }
                
            if let placemark = placemarks?.first {
                var address = ""
                
                // make sure the address makes gramatical sense based on what information is available
                
                if placemark.subThoroughfare != nil {
                    address.append("\(placemark.subThoroughfare ?? ""), ")
                }
                
                if placemark.thoroughfare != nil {
                    address.append("\(placemark.thoroughfare ?? ""), ")
                }
                
                if placemark.locality != nil {
                    address.append("\(placemark.locality ?? ""), ")
                }
                
                if placemark.administrativeArea != nil {
                    address.append("\(placemark.administrativeArea ?? ""), ")
                }
                
                if placemark.country != nil {
                    address.append("\(placemark.country ?? "")")
                }
                
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
