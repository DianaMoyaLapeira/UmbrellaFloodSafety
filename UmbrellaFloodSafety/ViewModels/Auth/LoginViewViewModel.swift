//
//  LoginViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        // Try log in
        Auth.auth().signIn(withEmail: "\(username)@fakedomain.com", password: password)
        
        UserDefaults.standard.set(username, forKey: "lastLoggedInUsername")
        
        print(UserDefaults.standard.string(forKey: "lastLoggedInUsername"))
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        return true
    }
}
