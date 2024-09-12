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
    
    @Published var selection: String = "No Umbrella yet"
    @Published var location = CLLocationManager().location
    @Published var userGroups: Dictionary<String, String> = ["111111":"TestGroup"]
    
    init() {
        setupSubscriptions()
    }
    
    func printselection() {
        print("\(self.selection)")
    }
    
    private let db = Firestore.firestore()
    
    // get current user groups and keep it updated with Combine
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
        
        let userCoordinates = [location?.coordinate.latitude ?? 888, location?.coordinate.longitude ?? 888]
        
        db.collection("users")
            .document("\(firebaseManager.currentUserUsername)")
            .updateData(["location": userCoordinates]) { error in
                if let error = error {
                    print("Error updating location: \(error)")
                } else {
                    print("Location successfully updated")
                }
        }
    }
}
