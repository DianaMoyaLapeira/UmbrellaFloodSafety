//
//  MainViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var currentUserUsername: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler  = Auth.auth().addStateDidChangeListener { [weak self]_, user in
            DispatchQueue.main.async {
                // Dispatches on main thread (Main view) since it should be displayed on main
                let db = Firestore.firestore()
                self?.currentUserId = user?.uid ?? ""
                self?.currentUserUsername = user?.email?.replacingOccurrences(of: "@fakedomain.com", with: "") ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
