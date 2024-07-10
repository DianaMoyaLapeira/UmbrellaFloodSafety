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
                           isChild: true,
                           umbrellas: [],
                           conversationsIds: [])
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(username.lowercased())
            .setData(newUser.encodeJSONToDictionary())
        
        let logoImageData = UIImage(resource: .umbrellaLogo).jpegData(compressionQuality: 0.7)
        
        guard logoImageData != nil else {
            print("logo image data was nil")
            return
        }
        
        uploadImageIntoStorage(data: logoImageData!)
    }
    
    private func uploadImageIntoStorage(data: Data) {
        guard self.username != "" else {
            print("Username is empty")
            return
        }
        let storageRef = Storage.storage().reference().child("users/\(username.lowercased()).jpg")
        storageRef.putData(data, metadata: nil) { metadata, error in
            if let error = error {
                print("error while uploading image: \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error retrieving download pfp URL: \(error.localizedDescription)")
                } else if let url = url {
                    DispatchQueue.main.async {
                        StorageManager.shared.ProfileImageURL = url.absoluteString
                        print("Successfully obtained pfp URL: \( String(describing: StorageManager.shared.ProfileImageURL))")
                        
                    }
                }
            }
        }
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

