//
//  MessagingViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class MessagingViewViewModel: ObservableObject {
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}
