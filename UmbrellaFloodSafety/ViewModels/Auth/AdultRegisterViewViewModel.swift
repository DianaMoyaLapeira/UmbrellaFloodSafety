//
//  AdultRegisterViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth
import FirebaseStorage

class AdultRegisterViewViewModel: ObservableObject {
    
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
        let newUser = UserModel(id: id,
                            username: username,
                            name: name,
                            joined: Date().timeIntervalSince1970,
                            isChild: false,
                            umbrellas: [],
                            conversationsIds: [],
                            avatar: "skin11,shirt1,black,mouth1,,no")
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(username.lowercased())
            .setData(newUser.encodeJSONToDictionary())
        
        let logoImageData = UIImage(resource: .umbrellaLogo).jpegData(compressionQuality: 0.5)
        
        guard logoImageData != nil else {
            print("logo image data was nil")
            return
        }
        
    }
    
   
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        return true
    }
}


