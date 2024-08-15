//
//  MakeEmergencyPlanViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 6/8/24.
//

import Foundation
import FirebaseFirestore

class MakeEmergencyPlanViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    var documentId: String
    @Published var title: String
    @Published var dateUpdated: TimeInterval
    @Published var emergencyContacts: [EmergencyContact]
    @Published var petEmergencyInfo: [PetEmergencyInfo]
    @Published var mostLikelyDisasters: String
    @Published var escapeRouteFromHome: String
    @Published var meetingNearHome: String
    @Published var meetingOutsideNeighborhood: String
    @Published var firstChoiceRoute: String
    @Published var secondChoiceRoute: String
    @Published var externalEmergencyContact: [EmergencyContact]
    @Published var childEvacuationPlans: [childEvacuationPlan]
    @Published var specialNeedsEvacuationPlan: [SpecialNeedsEvacuationPlan]
    @Published var safeRoom: String
    @Published var usersInPlan: [String]
    
    init(emergencyPlan: EmergencyPlanModel?) {
        self.documentId = emergencyPlan?.id ?? UUID().uuidString
        self.title = emergencyPlan?.title ?? ""
        self.dateUpdated = emergencyPlan?.dateUpdated ?? Date().timeIntervalSince1970
        self.emergencyContacts = emergencyPlan?.emergencyContacts ?? []
        self.petEmergencyInfo = emergencyPlan?.petEmergencyInfo ?? []
        self.mostLikelyDisasters = emergencyPlan?.mostLikelyDisasters ?? ""
        self.escapeRouteFromHome = emergencyPlan?.escapeRouteFromHome ?? ""
        self.meetingNearHome = emergencyPlan?.meetingNearHome ?? ""
        self.meetingOutsideNeighborhood = emergencyPlan?.meetingOutsideNeighborhood ?? ""
        self.firstChoiceRoute = emergencyPlan?.firstChoiceRoute ?? ""
        self.secondChoiceRoute = emergencyPlan?.secondChoiceRoute ?? ""
        self.externalEmergencyContact = emergencyPlan?.externalEmergencyContact ?? []
        self.childEvacuationPlans = emergencyPlan?.childEvacuationPlans ?? []
        self.specialNeedsEvacuationPlan = emergencyPlan?.specialNeedsEvacuationPlan ?? []
        self.safeRoom = emergencyPlan?.safeRoom ?? ""
        self.usersInPlan = emergencyPlan?.usersInPlan ?? [FirebaseManager.shared.currentUserUsername]
    }
    
    
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
                "safeRoom": safeRoom,
                "usersInPlan": usersInPlan
            ])
        
        // Put in subcollections
        
        // Put in emergency contacts
        
        for emergencyContact in emergencyContacts {
            db.collection("emergencyPlans/\(documentId)/emergencyContacts")
                .document(emergencyContact.id)
                .setData(emergencyContact.encodeJSONToDictionary())
        }
        
        // pet emergency info
        
        for petInfo in petEmergencyInfo {
            db.collection("emergencyPlans/\(documentId)/petInfo")
                .document(petInfo.id)
                .setData(petInfo.encodeJSONToDictionary())
        }
        
        // external emergency contact info
        
        for contact in externalEmergencyContact {
            db.collection("emergencyPlans/\(documentId)/externalEmergencyContacts")
                .document(contact.id)
                .setData(contact.encodeJSONToDictionary())
        }
        
        // child evacuation plan
        
        for childEvacuationPlan in childEvacuationPlans {
            db.collection("emergencyPlans/\(documentId)/childEvacuationPlans")
                .document(childEvacuationPlan.id)
                .setData(childEvacuationPlan.encodeJSONToDictionary())
        }
        
        // special needs/disabilities evacuation plan
        
        for plan in specialNeedsEvacuationPlan {
            db.collection("emergencyPlans/\(documentId)/specialNeedsDisabilitiesEvacuationPlans")
                .document(plan.id)
                .setData(plan.encodeJSONToDictionary())
        }
        
        EmergencyPlanIntoUser()
            
    }
    
    func EmergencyPlanIntoUser() {
        
        for user in usersInPlan {
            db.collection("users")
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
    
    // delete emergency plan (as a whole)
    
    func deleteEmergencyPlan() {
        
        
        for user in usersInPlan {
            db.collection("users")
                .document(user)
                .updateData([
                    "emergencyPlans" : FieldValue.arrayRemove([documentId])
            ]) { error in
                if let error = error {
                    print("Error deleting emergency plan from user doc \(error)")
                } else {
                    print("Sucessfully remove demergency plan from user doc")
                }
            }
        }
        
        db.collection("emergencyPlans")
            .document(documentId)
            .delete { error in
                if let error = error {
                    print("An error occurred deleting emergency plan \(error)")
                }
        }
    }
    
    // delete parts of the plan
    
    func deleteEmergencyContact(contact: EmergencyContact, type: String) {
        // type is either emergencyContacts or externalEmergencyContact
        
        self.emergencyContacts.removeAll { contactInList in
            contactInList.id == contact.id
        }
        
        self.externalEmergencyContact.removeAll { contactInList in
            contactInList.id == contact.id
        }
        
        db.collection("emergencyPlans/\(documentId)/\(type)")
            .document(contact.id)
            .delete { error in
                print("Error deleting emergency contact from plan")
            }
        
    }
    
    func deletePetInfo(petInfo: PetEmergencyInfo) {
        self.petEmergencyInfo.removeAll { petEmergency in
            petEmergency.id == petInfo.id
        }
        
        db.collection("emergencyPlans/\(documentId)/petInfo")
            .document(petInfo.id)
            .delete { error in
                print("Error deleting pet information from plan")
            }
    }
    
    func deleteChildPlan(childPlan: childEvacuationPlan) {
        
        self.childEvacuationPlans.removeAll { plan in
            plan.id == childPlan.id
        }
        
        db.collection("emergencyPlans/\(documentId)/childEvacuationsPlan")
            .document(childPlan.id)
            .delete()
    }
    
    func deleteDisabilityPlan(disabilityPlan: SpecialNeedsEvacuationPlan) {
        
        self.specialNeedsEvacuationPlan.removeAll { SpecialNeedsEvacuationPlan in
            SpecialNeedsEvacuationPlan.id == disabilityPlan.id
        }
        
        db.collection("emergencyPlans/\(documentId)/specialNeedsDisabilitiesEvacuationPlans")
            .document(disabilityPlan.id)
            .delete()
    }
}
