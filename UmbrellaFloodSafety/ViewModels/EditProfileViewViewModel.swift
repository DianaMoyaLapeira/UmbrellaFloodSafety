//
//  EditProfileViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class EditProfileViewViewModel {
    
    var username: String
    var name: String
    var password: String
    
    let db = Firestore.firestore()
    
    init(username: String) {
        self.username = username
        self.name = ""
        self.password = ""
    }
    
    func saveChanges() {
        
        if !self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            resetName()
        }
        
        if !self.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            resetPassword()
        }
    }
    
    private func resetName() {
        guard !self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return }
        
        db.collection("users").document("\(self.username)").setData(["name": self.name])
    }
    
    private func resetPassword() {
        guard !self.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
        
        guard self.password.count >= 6 else {return }
        
        Auth.auth().currentUser?.updatePassword(to: self.password) { error in
            if let error = error {
                print("An error occured: \(error)")
                return
            } else {
                print("Succesfully updated password")
                return
            }
        }
    }
}
