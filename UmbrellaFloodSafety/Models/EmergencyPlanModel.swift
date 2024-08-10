//
//  EmergencyPlanModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/8/24.
//

import Foundation

struct EmergencyPlanModel: Codable, Identifiable {
    
    var id: String
    var title: String
    var dateUpdated: TimeInterval
    var emergencyContacts: [EmergencyContact]
    var petEmergencyInfo: [PetEmergencyInfo]
    var mostLikelyDisasters: String
    var escapeRouteFromHome: String
    var meetingNearHome: String
    var meetingOutsideNeighborhood: String
    var firstChoiceRoute: String
    var secondChoiceRoute: String
    var externalEmergencyContact: [EmergencyContact]
    var childEvacuationPlans: [childEvacuationPlan]
    var specialNeedsEvacuationPlan: [SpecialNeedsEvacuationPlan]
    var safeRoom: String
    var usersInPlan: [String]

}
