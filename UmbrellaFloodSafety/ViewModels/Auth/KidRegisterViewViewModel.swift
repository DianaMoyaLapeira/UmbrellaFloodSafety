//
//  RegisterAsKidViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//
import CoreLocation
import FirebaseFirestore
import Foundation
import FirebaseAuth
import FirebaseStorage

class KidRegisterViewViewModel: ObservableObject {
    
    
    @Published var username = ""
    @Published var name = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        // Make sure the username and password are valid
        guard validate() else {
            return
        }
        
        // Create user in firebase auth with pretend email
        Auth.auth().createUser(withEmail: "\(username)@fakedomain.com", password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        
        // Create user in firestore
        
        let newUser = UserModel(id: id,
                           username: username,
                           name: name,
                           joined: Date().timeIntervalSince1970,
                           isChild: true,
                           umbrellas: [],
                            conversationsIds: [],
                            avatar: "skin11,shirt1,black,mouth1,,")
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(username.lowercased())
            .setData(newUser.encodeJSONToDictionary())
       
    }
    
    
    private func validate() -> Bool {
        
        // Make sure none of the fields are empty
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            print("Validate failed")
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            print("Password invalid")
            return false
        }
        
       // add username validation later to make sure no users have duplicate usernames
        return true
    }
}

