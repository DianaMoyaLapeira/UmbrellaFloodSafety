//
//  conversation.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/7/24.
//

import Foundation


struct message: Codable, Hashable, Identifiable {
    var id: String
    var timestamp: TimeInterval
    var content: String
    var senderId: String
}

struct conversation: Codable {
    var id: String
    var lastMessage: String
    var lastMessageTimestamp: TimeInterval
    let participants: [String]
}
