//
//  NotificationViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 19/7/24.
//

import Foundation
import SwiftUI
import CoreLocation

class NotificationViewViewModel: ObservableObject {
    
    @Published var firebaseManager = FirebaseManager.shared
    @Published var notifications: [Notification] = []
    static let shared = NotificationViewViewModel()
    
    func getRiskNotifications() {
        
        self.notifications = []
        
        for (member, memberLocation) in firebaseManager.groupMembersLocations {
            Task {
                let riskLevel = await WeatherManager().getRiskLevel(coordinate: memberLocation)
                
                switch riskLevel {
                case 1: notifications.append(Notification(id: Date().timeIntervalSince1970, title: "\(firebaseManager.usernameToName[member] ?? member)", content: "Flood watch/advisory in \(member)'s area.", username: member))
                case 2: notifications.append(Notification(id: Date().timeIntervalSince1970, title: "\(firebaseManager.usernameToName[member] ?? member)", content: "Flood warning in \(member)'s area.", username: member))
                default: break
                }
            }
        }
        
        print(self.notifications)
    }
}
