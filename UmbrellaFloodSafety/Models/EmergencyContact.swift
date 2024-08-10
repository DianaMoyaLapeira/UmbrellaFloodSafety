//
//  EmergencyContact.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 6/8/24.
//

import Foundation

struct EmergencyContact: Codable, Identifiable {
    
    var id: String
    var name: String
    var homePhoneNumber: String = ""
    var cellPhoneNumber: String = ""
    var email: String = ""
    
}
