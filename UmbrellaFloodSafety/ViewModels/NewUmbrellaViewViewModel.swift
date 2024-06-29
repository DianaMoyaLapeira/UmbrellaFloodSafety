//
//  NewUmbrellaViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import Foundation

@Observable
class NewUmbrellaViewViewModel {
   
    var groupName = ""
    let currentUsername: String
   
    
    init(Username: String) {
        self.currentUsername = Username
        print(self.currentUsername)
    }
    
    
    func registerGroup() {
        
        let GroupId = UUID().uuidString
        guard validate() else {
            print("Failed validation")
            return
        }
        let newGroup = Group(id: GroupId, name: groupName, members: [currentUsername])
        
        let db = Firestore.firestore()
        
        db.collection("groups")
            .document(GroupId)
            .setData(newGroup.encodeJSONToDictionary())
        
        let userdocref = db.collection("users")
            .document(self.currentUsername)
        
        userdocref.updateData([
            "umbrellas": FieldValue.arrayUnion([GroupId])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    private func validate() -> Bool {
        guard !groupName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
    
}
