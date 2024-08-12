//
//  childEvacuationPlan.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 6/8/24.
//

import Foundation

struct childEvacuationPlan: Codable, Identifiable {
    
    var id: String
    var name: String
    var evacuationSite: String
    var contactInfo: String = ""
    
}
