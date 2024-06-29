//
//  LearnViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class LearnViewViewModel: ObservableObject {
    
    private let username: String
    
    init(username: String) {
        self.username = username
    }
}
