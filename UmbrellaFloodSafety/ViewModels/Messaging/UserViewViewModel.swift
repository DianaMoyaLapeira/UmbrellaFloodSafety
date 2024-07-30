//
//  UserViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/7/24.
//

import Foundation
import FirebaseFirestore

class UserViewViewModel: ObservableObject {
    
    var firebaseManager = FirebaseManager.shared
    
    func blockUser(blockedUser: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(firebaseManager.currentUserUsername).updateData([
            "blockedUsers": FieldValue.arrayUnion([blockedUser])
        ]) { error in
            if let error = error {
                print("Error blocking user: \(error)")
            } else {
                print("User successfully blocked")
            }
        }
        
        for (group, memberArray) in firebaseManager.groupMembers {
            
            if memberArray.contains(blockedUser) {
                
                db.collection("groups").document(group).updateData([
                    "members": FieldValue.arrayRemove([firebaseManager.currentUserUsername])
                ]) { error in
                    if let error = error {
                        print("Error removing user from group with blocked person: \(error)")
                    } else {
                        print("Successfully removed user from group with blocked person")
                    }
                }
                
                db.collection("users").document(firebaseManager.currentUserUsername).updateData([
                    "umbrellas": FieldValue.arrayRemove([group])
                ])
            }
        }
    }
    
    func reportUser(sender: String, reported: String, reason: String) {
        let db = Firestore.firestore()
        let reportId = UUID().uuidString
        let newReport = Report(id: reportId, sender: sender, reported: reported, reason: reason)
        
        db.collection("reports")
            .document(reportId)
            .setData(newReport.encodeJSONToDictionary())
    }
}
