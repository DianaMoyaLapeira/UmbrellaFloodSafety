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
   
    var firebaseManager = FirebaseManager.shared
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
        
        groupdocref.getDocument { (document, error) in
            
            if let error = error {
                print("\(error.localizedDescription)")
            }
            
            guard let document = document, document.exists else {
                print("Group you are trying to join does not exist")
                
                return
            }
            
            if let groupMembers = document.get("members") as? [String] {
                for member in groupMembers {
                    guard !self.firebaseManager.blockedUsers.contains(member) else {
                        print("Blocked user is in this group. Unblock user to join")
                        return
                    }
                }
            }
          
        }
        
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
        
        insertConversations(GroupId: GroupId)
        
    }
    
    func insertConversations(GroupId: String) {
        
        // first, get a list of all the users in the document
        var memberarray: [String] = []
        
        let db = Firestore.firestore()
        
        let docrefgroups = db.collection("groups")
            .document(GroupId)
        
        let docrefconvos = db.collection("conversations")
        
        
        docrefgroups.getDocument { document, error in
            guard let document = document, document.exists else {
                print("There is no document for the group")
                return
            }
            if let member = document.get("members") as? [String] {
                memberarray = member.filter {
                    $0 != self.firebaseManager.currentUserUsername
                }
                print(memberarray)
            }
        
        for member in memberarray {
            let checkmemberinconvo = self.isMemberinConversations(member: member)
            print("check member inconvo: \(checkmemberinconvo)")
            if checkmemberinconvo == "" {
                // add conversation with other group member
                // add current user
                let id = UUID().uuidString
                let newConvo = conversation(id: id,
                                            lastMessage: "No messages yet",
                                            lastMessageTimestamp: Date().timeIntervalSince1970,
                                            participants: [self.firebaseManager.currentUserUsername, member])
                docrefconvos
                    .document(id)
                    .setData(newConvo.encodeJSONToDictionary())
                
                
                db.collection("users")
                    .document(self.firebaseManager.currentUserUsername)
                    .updateData(["conversationsIds": FieldValue.arrayUnion([id])
                ]) { error in
                    if let error = error {
                        print("Error updating user document when inserting a new group: \(error)")
                    } else {
                        print("User document when inserting a new group successfully updated")
                    }
                }
                
                db.collection("users")
                    .document(member)
                    .updateData(["conversationsIds": FieldValue.arrayUnion([id])
                ]) { error in
                    if let error = error {
                        print("Error updating user document when inserting a new group: \(error)")
                    } else {
                        print("User document when inserting a new group successfully updated")
                    }
                }
            } else {
                // add user to conversation
                
                docrefconvos
                    .document(checkmemberinconvo)
                    .updateData(["participants": FieldValue.arrayUnion([self.firebaseManager.currentUserUsername])]) {
                        error in
                        if let error = error {
                            print("Error updating user document when inserting a new group: \(error)")
                        } else {
                            print("Group document successfully updated for new participant")
                        }
                    }
                
                db.collection("users")
                    .document(self.firebaseManager.currentUserUsername)
                    .updateData(["conversationsIds": FieldValue.arrayUnion([checkmemberinconvo])
                                ]) { error in
                        if let error = error {
                            print("Error updating user document when inserting a new group: \(error)")
                        } else {
                            print("user document when inserting a new group successfully updated")
                        }
                    }
                }
            }
        }
    }
    
    private func isMemberinConversations(member: String) -> String {
        for (_, conversation) in firebaseManager.conversations {
            if conversation.participants.contains(member) {
                return conversation.id
            } else {
                return ""
            }
        }
        return ""
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
