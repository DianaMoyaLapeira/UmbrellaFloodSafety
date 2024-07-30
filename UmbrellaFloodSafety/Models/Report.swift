//
//  Report.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/7/24.
//

import Foundation

struct Report: Codable {
    
    let id: String
    let sender: String
    let reported: String
    let reason: String
}
