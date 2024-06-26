//
//  MapViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 25/6/24.
//

import FirebaseCore
import FirebaseAuth
import Foundation

class MapViewViewModel: ObservableObject {
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}
