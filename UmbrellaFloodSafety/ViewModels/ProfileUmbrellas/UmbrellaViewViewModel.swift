//
//  UmbrellaViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/15/24.
//

import Foundation
import FirebaseFirestore

class UmbrellaViewViewModel: ObservableObject {
    
    func leaveUmbrella(umbrellaId: String) {
        
        let db = Firestore.firestore()
        
        // clear from group doc
        
        db.collection("groups").document(umbrellaId).updateData([
            "members" : FieldValue.arrayRemove([FirebaseManager.shared.currentUserUsername])]
        )
        
        // clear from user doc
        
        db.collection("users").document(FirebaseManager.shared.currentUserUsername).updateData([
            "umbrellas" : FieldValue.arrayRemove([umbrellaId])
        ])
    }
}
