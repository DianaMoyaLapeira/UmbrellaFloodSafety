//
//  ProfileViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseCore

class ProfileViewViewModel: ObservableObject {
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
}
