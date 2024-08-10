//
//  PetEmergencyInfo.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 6/8/24.
//

import Foundation

struct PetEmergencyInfo: Codable, Identifiable {
    
    var id: String
    var name: String = ""
    var type: String = ""
    var color: String = ""
    var registrationNumber: String = ""
}
