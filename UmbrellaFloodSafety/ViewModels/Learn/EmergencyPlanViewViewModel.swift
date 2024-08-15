//
//  EmergencyPlanViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/15/24.
//

import Foundation
import FirebaseFirestore

class EmergencyPlanViewViewModel: ObservableObject {
    
    func exitPlan(planId: String) {
        
        let currentUsername = FirebaseManager.shared.currentUserUsername
        
        guard currentUsername != "" else { return }
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(planId).updateData([
            "usersInPlan": FieldValue.arrayRemove([currentUsername])
        ]) { error in
            if let error = error {
                print("Error removing user from emergency plan: \(error)")
            } else {
                print("Successfully removed user from emergency plan")
            }
        }
        
        db.collection("users").document(currentUsername).updateData([
            "emergencyPlans" : FieldValue.arrayRemove([planId])
        ]) { error in
            if let error = error {
                print("Error removing emergency plan from user doc: \(error)")
            } else {
                print("Successfully removed emergency plan from user doc")
            }
        }
    }
}
