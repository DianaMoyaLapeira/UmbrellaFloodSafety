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
    var characterOne: String = ""
    var characterTwo: String = ""
    var characterThree: String = ""
    var characterFour: String = ""
    var characterFive: String = ""
    var characterSix: String = ""
    
    init(Username: String) {
        self.currentUsername = Username
    }
    
    
    func registerGroup() {
        
        let GroupId = random(digits: 6)
        guard validate() else {
            print("Failed validation")
            return
        }
        let newGroup = Group(id: GroupId, name: groupName, members: [currentUsername])
        
        let db = Firestore.firestore()
        
        db.collection("groups")
            .document(GroupId)
            .setData(newGroup.encodeJSONToDictionary())
        
        groupRecordIntoUser(GroupId: GroupId)
        
    }
    
    func joinGroup(GroupId: String) {
        let db = Firestore.firestore()
        
        let groupdocref = db.collection("groups")
            .document(GroupId)
        
        groupdocref.updateData([
            "members": FieldValue.arrayUnion([self.currentUsername])
        ]) { error in
            if let error = error {
                print("Error updating group document: \(error)")
            } else {
                print("Group document succesfully updated")
            }
        }
        
        groupRecordIntoUser(GroupId: GroupId)
    }
    
    func groupRecordIntoUser(GroupId: String) {
        
        let db = Firestore.firestore()
        
        let userdocref = db.collection("users")
            .document(self.currentUsername)
        
        userdocref.updateData([
            "umbrellas": FieldValue.arrayUnion([GroupId])
        ]) { error in
            if let error = error {
                print("Error updating user document: \(error)")
            } else {
                print("User document successfully updated")
            }
        }
        
    }
    
    private func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }

    
    private func validate() -> Bool {
        guard !groupName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
    
}
