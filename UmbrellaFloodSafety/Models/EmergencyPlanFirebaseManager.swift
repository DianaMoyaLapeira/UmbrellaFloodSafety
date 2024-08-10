//
//  EmergencyPlanFirebaseManager.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 8/8/24.
//
// Note to whoever is reading this: I'm making this as I have a fever. It may not be as optimized as hoped for. Not feeling great

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EmergencyPlanFirebaseManager: ObservableObject {
    
    static let shared = EmergencyPlanFirebaseManager()
    
    @Published var emergencyPlans: [String: EmergencyPlanModel] = [:] // PlanId to Plan
    
    var currentUserUsername: String = ""
    private var planListeners: [ListenerRegistration] = []
    
    func setUpPlanListeners(emergencyPlans: [String]) {
        // Clear plans so new listeners can be put in
        planListeners.removeAll()
        
        let db = Firestore.firestore()
      
        for emergencyPlan in emergencyPlans {
            let emergencyPlanListener = db.collection("emergencyPlans").document(emergencyPlan).addSnapshotListener { documentSnapshot, error in
                
                var emergencyPlanTemplate = EmergencyPlanModel(id: "", title: "", dateUpdated: 0, emergencyContacts: [], petEmergencyInfo: [], mostLikelyDisasters: "", escapeRouteFromHome: "", meetingNearHome: "", meetingOutsideNeighborhood: "", firstChoiceRoute: "", secondChoiceRoute: "", externalEmergencyContact: [], childEvacuationPlans: [], specialNeedsEvacuationPlan: [], safeRoom: "", usersInPlan: [])
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let document = documentSnapshot, document.exists else {
                    print("Error fetching emergency plan document: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                if let planId = document.get("id") as? String {
                    emergencyPlanTemplate.id = planId
                }
                
                if let planTitle = document.get("title") as? String {
                    emergencyPlanTemplate.title = planTitle
                }
                
                if let planDateUpdated = document.get("dateUpdated") as? CGFloat {
                    emergencyPlanTemplate.dateUpdated = planDateUpdated
                }
                
                emergencyPlanTemplate.emergencyContacts = self.fetchEmergencyContacts(emergencyPlan: emergencyPlan, subcollection: "emergencyContacts")
                
                emergencyPlanTemplate.petEmergencyInfo = self.fetchPetEmergencyInfo(emergencyPlan: emergencyPlan)
                
                if let planLikelyDisasters = document.get("mostLikelyDisasters") as? String {
                    emergencyPlanTemplate.mostLikelyDisasters = planLikelyDisasters
                }
                
                if let planEscapeFromHome = document.get("escapeRouteFromHome") as? String {
                    emergencyPlanTemplate.escapeRouteFromHome = planEscapeFromHome
                }
                
                if let planMeetingNearHome = document.get("meetingNearHome") as? String {
                    emergencyPlanTemplate.meetingNearHome = planMeetingNearHome
                }
                
                if let planMeetingOutsideNeighborhood = document.get("meetingOutsideNeighborhood") as? String {
                    emergencyPlanTemplate.meetingOutsideNeighborhood = planMeetingOutsideNeighborhood
                }
                
                if let planFirstChoiceRoute = document.get("firstChoiceRoute") as? String {
                    emergencyPlanTemplate.firstChoiceRoute = planFirstChoiceRoute
                }
                
                if let planSecondChoiceRoute = document.get("secondChoiceRoute") as? String {
                    emergencyPlanTemplate.secondChoiceRoute = planSecondChoiceRoute
                }
                
                emergencyPlanTemplate.externalEmergencyContact = self.fetchEmergencyContacts(emergencyPlan: emergencyPlan, subcollection: "externalEmergencyContacts")
                
                emergencyPlanTemplate.childEvacuationPlans = self.fetchChildEvacuationPlan(emergencyPlan: emergencyPlan)
                
                emergencyPlanTemplate.specialNeedsEvacuationPlan = self.fetchSpecialNeedsEvacuationPlan(emergencyPlan: emergencyPlan)
                
                if let planSafeRoom = document.get("safeRoom") as? String {
                    emergencyPlanTemplate.safeRoom = planSafeRoom
                }
                
                if let planUsers = document.get("usersInPlan") as? [String] {
                    emergencyPlanTemplate.usersInPlan = planUsers
                }
                
                self.emergencyPlans[emergencyPlanTemplate.id] = emergencyPlanTemplate
            }
    
            self.planListeners.append(emergencyPlanListener)
            
        }
    }
    
    func fetchEmergencyContacts(emergencyPlan: String, subcollection: String) -> [EmergencyContact] {
        // fetch emergency contacts for this plan
        
        var emergencyContacts: [EmergencyContact] = []
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(emergencyPlan).collection(subcollection).getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured fetching emergency contacts: \(error.localizedDescription)")
                return
            }
            
            guard let documents = documentsSnapshot, !documents.isEmpty else {
                print("An error occured fetching emergency contacts: \(String(describing: error?.localizedDescription))")
                return
            }
            
            
            for contactDocument in documents.documents {
                
                var emergencyContactTemplate = EmergencyContact(id: "", name: "")
                
                let contactData = contactDocument.data()
                
                emergencyContactTemplate.id = contactData["id"] as? String ?? ""
                
                emergencyContactTemplate.name = contactData["name"] as? String ?? ""
                
                emergencyContactTemplate.homePhoneNumber = contactData["homePhoneNumber"] as? String ?? ""
                
                emergencyContactTemplate.cellPhoneNumber = contactData["cellPhoneNumber"] as? String ?? ""
                
                emergencyContactTemplate.email = contactData["email"] as? String ?? ""
                
                emergencyContacts.append(emergencyContactTemplate)
            }
            
        }
        
        return emergencyContacts
        
    }
    
    func fetchPetEmergencyInfo(emergencyPlan: String) -> [PetEmergencyInfo] {
        // fetch pet emergency info for this plan
        
        var petEmergencyInfo: [PetEmergencyInfo] = []
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(emergencyPlan).collection("petInfo").getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured fetching pet emergency info: \(error)")
                return
            }
            
            guard let documents = documentsSnapshot, !documents.isEmpty else {
                print("An error occured fetching pet emergency info or no pet info is available: \(String(describing: error))")
                return
            }
            
            for petInfoDocument in documents.documents {
                
                var petInfoTemplate = PetEmergencyInfo(id: "")
                
                let petData = petInfoDocument.data()
                
                petInfoTemplate.id = petData["id"] as? String ?? ""
                
                petInfoTemplate.name = petData["name"] as? String ?? ""
                
                petInfoTemplate.type = petData["type"] as? String ?? ""
                
                petInfoTemplate.registrationNumber = petData["registrationNumber"] as? String ?? ""
                
                petEmergencyInfo.append(petInfoTemplate)
            }
        }
        
        return petEmergencyInfo
    }
    
    func fetchChildEvacuationPlan(emergencyPlan: String) -> [childEvacuationPlan] {
        
        var childEvacuationPlans: [childEvacuationPlan] = []
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(emergencyPlan).collection("childEvacuationsPlan").getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured when fetching child evacuation plans: \(error)")
                return
            }
            
            guard let documents = documentsSnapshot, !documents.isEmpty else {
                print("An error occured or no documents when fetching child evacuation plans: \(String(describing: error))")
                return
            }
            
            for childEvacuationDocument in documents.documents {
                
                var childEvacuationTemplate = childEvacuationPlan(id: "", name: "", evacuationSite: "")
                
                let childEvacuationData = childEvacuationDocument.data()
                
                childEvacuationTemplate.id = childEvacuationData["id"] as? String ?? ""
                
                childEvacuationTemplate.name = childEvacuationData["name"] as? String ?? ""
                
                childEvacuationTemplate.evacuationSite = childEvacuationData["evacuationSite"] as? String ?? ""
                
                childEvacuationTemplate.contactInfo = childEvacuationData["contactInfo"] as? String ?? ""
                
                childEvacuationPlans.append(childEvacuationTemplate)
            }
        }
        
        return childEvacuationPlans
    }
    
    func fetchSpecialNeedsEvacuationPlan(emergencyPlan: String) -> [SpecialNeedsEvacuationPlan] {
        
        var specialNeedsEvacuationPlans: [SpecialNeedsEvacuationPlan] = []
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(emergencyPlan).collection("specialNeedsDisabilitiesEvacuationPlans").getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured when fetching special needs/disabilities plans: \(error)")
            }
            
            guard let documents = documentsSnapshot, !documents.isEmpty else {
                print("An error occured or no documents when fetching special needs/disabilities plans \(String(describing: error))")
                return
            }
            
            for evacuationPlanDocument in documents.documents {
                
                var specialNeedsEvacuationTemplate = SpecialNeedsEvacuationPlan(id: "", name: "", plan: "")
                
                let evacuationPlanData = evacuationPlanDocument.data()
                
                specialNeedsEvacuationTemplate.id = evacuationPlanData["id"] as? String ?? ""
                
                specialNeedsEvacuationTemplate.name = evacuationPlanData["name"] as? String ?? ""
                
                specialNeedsEvacuationTemplate.plan = evacuationPlanData["plan"] as? String ?? ""
                
                specialNeedsEvacuationPlans.append(specialNeedsEvacuationTemplate)
            }
        }
        
        return specialNeedsEvacuationPlans
    }
}
