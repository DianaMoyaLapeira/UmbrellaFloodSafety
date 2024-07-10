//
//  StorageManager.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 30/6/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class StorageManager: ObservableObject {
    static let shared = StorageManager()
    
    var firebaseManager = FirebaseManager.shared
    @Published var ProfileImageURL: String = ""
    @Published var profileImage: Image = Image(.umbrellaLogo)
    
    init(firebaseManager: FirebaseManager = FirebaseManager.shared, ProfileImageURL: URL? = nil) {
        self.firebaseManager = firebaseManager
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fetchProfileImageURL()
        }
    }
    
    func fetchProfileImageURL() {
        let storageRef = Storage.storage().reference().child("users/\(firebaseManager.currentUserUsername).jpg")
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching download URL womp: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                guard url != nil else {
                    print("URL is nil")
                    return
                }
                self.ProfileImageURL = url?.absoluteString ?? ""
            }
        }
    }
    
    func imageURLToImage(imageURL: String) {
        guard let URL = URL(string: imageURL) else {
            print("URL provided was not valid.")
            return
        }
        
        let storageRef = Storage.storage().reference(forURL: imageURL)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImage = Image(uiImage: uiImage)
                }
            }
        }
    }
}
