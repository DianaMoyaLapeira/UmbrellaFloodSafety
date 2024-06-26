//
//  RegisterAsKidViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth

class KidRegisterViewViewModel: ObservableObject {
    
    
    @Published var username = ""
    @Published var name = ""
    @Published var password = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: "\(username)@fakedomain.com", password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           username: username,
                           name: name,
                           joined: Date().timeIntervalSince1970,
                           isChild: true)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.encodeJSONToDictionary())
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("Validate failed")
            return false
        }
        
        guard password.count >= 6 else {
            print("Password invalid")
            return false
        }
        return true
    }
}

