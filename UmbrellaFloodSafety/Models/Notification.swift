//
//  Notification.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 19/7/24.
//

import Foundation

struct Notification: Identifiable {
    var id: TimeInterval
    let title: String
    let content: String
    let username: String
}
