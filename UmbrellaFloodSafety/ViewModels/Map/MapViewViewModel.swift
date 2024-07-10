//
//  MapViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import Foundation
import CoreLocation
import Combine


class MapViewViewModel: ObservableObject {
    
    static let shared = MapViewViewModel()
    
    var isLoading = true
    private var cancellables = Set<AnyCancellable>()
    
    var firebaseManager = FirebaseManager.shared
    var username: String = ""
    
    @Published var selection: String = "No Umbrella yet"
    @Published var location = CLLocationManager().location
    @Published var userGroups: Dictionary<String, String> = ["111111":"TestGroup"]
    
    init() {
        getUsername()
        setupSubscriptions()
    }
    
    func printselection() {
        print("\(self.selection)")
    }
    
    private let db = Firestore.firestore()
    
    private func getUsername() {
        self.username = firebaseManager.currentUserUsername
    }
    
    private func setupSubscriptions() {
            firebaseManager.$userGroups
                .sink { [weak self] userGroups in
                    guard let self = self else { return }
                    if let firstId = userGroups.keys.sorted().first {
                        self.selection = firstId
                        print("\(self.selection) what")
                        self.isLoading = false
                    } else {
                        self.selection = "No Umbrellas yet"
                    }
                }
                .store(in: &cancellables)
        }
    
    func updateLocationinDB() {
        
        let userGeoPoint = GeoPoint(latitude: location?.coordinate.latitude ?? 888, longitude: location?.coordinate.longitude ?? 888)
        
        db.collection("users")
            .document("\(username)")
            .updateData(["location": userGeoPoint]) { error in
                if let error = error {
                    print("Error updating location: \(error)")
                } else {
                    print("Location successfully updated")
                }
        }
    }
}
