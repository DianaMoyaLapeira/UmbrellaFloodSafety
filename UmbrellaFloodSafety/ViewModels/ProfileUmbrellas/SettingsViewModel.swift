//
//  SettingsViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/7/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import CoreLocation

class SettingsViewModel: ObservableObject {
    
    var firebaseManager = FirebaseManager.shared
    var currentUsername = FirebaseManager.shared.currentUserUsername
    
    func deleteAccount() {
        
        UserDefaults.standard.removeObject(forKey: "avatar")
        UserDefaults.standard.removeObject(forKey: "lastLoggedInUsername")
      
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        // delete groups
        for group in firebaseManager.userGroups.keys {
            db.collection("groups").document(group).updateData([
                "members": FieldValue.arrayRemove([currentUsername])
            ]) { error in
                if let error = error {
                    print("Error removing deleted user from group: \(error)")
                } else {
                    print("Successfully removed deleted user from group")
                }
            }
        }
        
        // delete conversations
        for (conversation, conversationInfo) in firebaseManager.conversations {
            
            if conversationInfo.participants.count == 2 {
                db.collection("conversations").document(conversation).delete { error in
                    if let error = error {
                        print("Error deleting conversation: \(error)")
                    } else {
                        print("Successfully deleted conversation")
                    }
                }
            } else {
                db.collection("conversations").document(conversation).updateData([
                    "members": FieldValue.arrayRemove([currentUsername])
                ]) { error in
                    if let error = error {
                        print("Error removing deleted user from conversation: \(error)")
                    } else {
                        print("Successfully removed deleted user from conversation")
                    }
                }
            }
        }
        
        for emergencyPlan in EmergencyPlanFirebaseManager().emergencyPlans.keys {
            db.collection("emergencyPlans").document(emergencyPlan).updateData([
                "usersInPlan" : FieldValue.arrayRemove([currentUsername])
            ]) { error in
                if let error = error {
                    print("An error occurred deleting user from emergency plan \(error)")
                } else {
                    print("Successfully removed deleted user from emergency plan")
                }
            }
        }
        
        db.collection("users").document(firebaseManager.currentUserUsername).delete { (error) in
            if let error = error {
                print("Error \(error) occured deleting the user in user db")
            } else {
                print("Successfully deleted the user in user db")
            }
        }
        
        user?.delete { error in
            if let error = error {
                print("An error deleting the user in auth occurred: \(error)")
            } else {
                print("Successfully deleted user in auth")
            }
        }
    }
    
    func inputEmail(email: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(firebaseManager.currentUserUsername).updateData(["email": email])
    }
    
    func unblockUser(user: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(firebaseManager.currentUserUsername).updateData([
            "blockedUsers": FieldValue.arrayRemove([firebaseManager.currentUserUsername])
        ]) { error in
            if let error = error {
                print("Error unblocking user: \(error)")
            } else {
                print("Successfully unblocked user")
            }
        }
    }
    
}
