//
//  MakeEmergencyPlanViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 6/8/24.
//

import Foundation
import FirebaseFirestore

class MakeEmergencyPlanViewModel: ObservableObject {
    
    let documentId: String = UUID().uuidString
    @Published var title: String = ""
    @Published var dateUpdated: TimeInterval = 0
    @Published var emergencyContacts: [EmergencyContact] = []
    @Published var petEmergencyInfo: [PetEmergencyInfo] = []
    @Published var mostLikelyDisasters: String = ""
    @Published var escapeRouteFromHome: String = ""
    @Published var meetingNearHome: String = ""
    @Published var meetingOutsideNeighborhood: String = ""
    @Published var firstChoiceRoute: String = ""
    @Published var secondChoiceRoute: String = ""
    @Published var externalEmergencyContact: [EmergencyContact] = []
    @Published var childEvacuationPlans: [childEvacuationPlan] = []
    @Published var specialNeedsEvacuationPlan: [SpecialNeedsEvacuationPlan] = []
    @Published var safeRoom: String = ""
    @Published var usersInPlan: [String] = [FirebaseManager.shared.currentUserUsername]
    
    
    func CreateEmergencyContact() {
        emergencyContacts.append(EmergencyContact(id: UUID().uuidString, name: ""))
    }
    
    func CreatePetInfo() {
        petEmergencyInfo.append(PetEmergencyInfo(id: UUID().uuidString))
    }
    
    func CreateExternalEmergencyContact() {
        externalEmergencyContact.append(EmergencyContact(id: UUID().uuidString, name: ""))
    }
    
    func CreateSpecialNeedsEvacuationPlan() {
        specialNeedsEvacuationPlan.append(SpecialNeedsEvacuationPlan(id: UUID().uuidString, name: "", plan: ""))
    }
    
    func CreateChildEvacuationPlan() {
        childEvacuationPlans.append(childEvacuationPlan(id: UUID().uuidString, name: "", evacuationSite: ""))
    }
    
    func uploadEmergencyPlanIntoDB() {
        // Upload emergency plan and all its components into the emergency plan collection
        let db = Firestore.firestore()
        
        // Put in basic data
        
        db.collection("emergencyPlans")
            .document(documentId)
            .setData([
                "id": documentId,
                "title": title,
                "dateUpdated": Date().timeIntervalSince1970,
                "mostLikelyDisasters": mostLikelyDisasters,
                "escapeRouteFromHome": escapeRouteFromHome,
                "meetingNearHome": meetingNearHome,
                "meetingOutsideNeighborhood": meetingOutsideNeighborhood,
                "firstChoiceRoute": firstChoiceRoute,
                "secondChoiceRoute": secondChoiceRoute,
                "safeRoom": safeRoom
            ])
        
        // Put in subcollections
        
        // Put in emergency contacts
        
        let emergencyContactReference = db.collection("emergencyPlans/\(documentId)/emergencyContacts")
        
        for emergencyContact in emergencyContacts {
            emergencyContactReference
                .document(emergencyContact.id)
                .setData(emergencyContact.encodeJSONToDictionary())
        }
        
        // pet emergency info
        
        let petEmergencyInfoReference = db.collection("emergencyPlans/\(documentId)/petInfo")
        
        for petInfo in petEmergencyInfo {
            petEmergencyInfoReference
                .document(petInfo.id)
                .setData(petInfo.encodeJSONToDictionary())
        }
        
        // external emergency contact info
        
        let externalEmergencyContactReference = db.collection("emergencyPlans/\(documentId)/externalEmergencyContacts")
        
        for contact in externalEmergencyContact {
            externalEmergencyContactReference
                .document(contact.id)
                .setData(contact.encodeJSONToDictionary())
        }
        
        // child evacuation plan
        
        let childEvacuationPlanReference = db.collection("emergencyPlans/\(documentId)/childEvacuationPlansReference")
        
        for childEvacuationPlan in childEvacuationPlans {
            childEvacuationPlanReference
                .document(childEvacuationPlan.id)
                .setData(childEvacuationPlan.encodeJSONToDictionary())
        }
        
        // special needs/disabilities evacuation plan
        
        let specialNeedsDisabilitiesEvacuationPlanReference = db.collection("emergencyPlans/\(documentId)/specialNeedsDisabilitiesEvacuationPlans")
        
        for plan in specialNeedsEvacuationPlan {
            specialNeedsDisabilitiesEvacuationPlanReference
                .document(plan.id)
                .setData(plan.encodeJSONToDictionary())
        }
        
        uploadEmergencyPlanIntoUserRecords()
            
    }
    
    func uploadEmergencyPlanIntoUserRecords() {
        // Upload emergency plan id into each user's document
        
        let db = Firestore.firestore()
        
        let userdocref = db.collection("users")
        
        for user in usersInPlan {
            userdocref
                .document(user)
                .updateData([
                "emergencyPlans": FieldValue.arrayUnion([documentId])
            ]) { error in
                if let error = error {
                    print("Error updating user document for new emergency plan: \(error)")
                } else {
                    print("User document successfully updated for new emergency plan")
                }
            }
        }
    }
}
