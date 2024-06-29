//
//  ProfileViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//
import FirebaseFirestore
import Foundation
import FirebaseAuth
import FirebaseCore

@Observable
class ProfileViewViewModel {
    
    let db = Firestore.firestore()
    
    let username: String
    
    var name: String
    
    init(username: String) {
        self.username = username
        print(self.username)
        self.name = ""
        getName()
    }
    
    func getName() -> Void {
        
        let _: Void = db.collection("users").document("\(username)").getDocument { (document, error) in
            if let document = document {
                let name = document.data()?["name"] as? String
                self.name = name ?? "No username"
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
}
