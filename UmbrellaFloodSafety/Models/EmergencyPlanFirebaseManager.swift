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
        
        let db = Firestore.firestore()
      
        for emergencyPlan in emergencyPlans {
            let emergencyPlanListener = db.collection("emergencyPlans").document(emergencyPlan).addSnapshotListener { documentSnapshot, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let document = documentSnapshot, document.exists else {
                    print("Error fetching emergency plan document: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                let emergencyPlanTemplate = EmergencyPlanModel(
                    id: document.get("id") as? String ?? "",
                    title: document.get("title") as? String ?? "",
                    dateUpdated: document.get("dateUpdated") as? CGFloat ?? 0,
                    emergencyContacts: [],
                    petEmergencyInfo: [],
                    mostLikelyDisasters: document.get("mostLikelyDisasters") as? String ?? "",
                    escapeRouteFromHome: document.get("escapeRouteFromHome") as? String ?? "",
                    meetingNearHome: document.get("meetingNearHome") as? String ?? "",
                    meetingOutsideNeighborhood: document.get("meetingOutsideNeighborhood") as? String ?? "",
                    firstChoiceRoute: document.get("firstChoiceRoute") as? String ?? "",
                    secondChoiceRoute: document.get("secondChoiceRoute") as? String ?? "",
                    externalEmergencyContact: [],
                    childEvacuationPlans: [],
                    specialNeedsEvacuationPlan: [],
                    safeRoom: document.get("safeRoom") as? String ?? "",
                    usersInPlan: document.get("usersInPlan") as? [String] ?? []
                )
                
                DispatchQueue.main.async {
                    self.emergencyPlans[emergencyPlan] = emergencyPlanTemplate
                }
                
                self.fetchEmergencyContacts(planId: emergencyPlan, subcollection: "emergencyContacts") { contacts in
                    DispatchQueue.main.async {
                        print("contacts \(contacts)")
                        self.emergencyPlans[emergencyPlan]?.emergencyContacts = contacts
                    }
                }
                
                self.fetchPetEmergencyInfo(planId: emergencyPlan) { petInfo in
                    DispatchQueue.main.async {
                        print("pet emergency \(petInfo)")
                        self.emergencyPlans[emergencyPlan]?.petEmergencyInfo = petInfo
                    }
                }
                
                self.fetchChildEvacuationPlan(planId: emergencyPlan) { plan in
                    DispatchQueue.main.async {
                        print("child plan: \(plan)")
                        self.emergencyPlans[emergencyPlan]?.childEvacuationPlans = plan
                    }
                }
                
                self.fetchEmergencyContacts(planId: emergencyPlan, subcollection: "externalEmergencyContacts") { contacts in
                    DispatchQueue.main.async {
                        self.emergencyPlans[emergencyPlan]?.externalEmergencyContact = contacts
                    }
                }
                
                self.fetchSpecialNeedsEvacuationPlan(planId: emergencyPlan) { plans in
                    DispatchQueue.main.async {
                        self.emergencyPlans[emergencyPlan]?.specialNeedsEvacuationPlan = plans
                    }
                }
                
            }
    
            self.planListeners.append(emergencyPlanListener)
            
        }
    }
    
    func fetchEmergencyContacts(planId: String, subcollection: String, completion: @escaping (([EmergencyContact]) -> Void )) {
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans/\(planId)/\(subcollection)").getDocuments { documentSnapshot, error in
            
            if let error = error {
                print("An error occured fetching pet emergency info: \(error)")
                completion([])
                return
            }
            
            var emergencyContacts: [EmergencyContact] = []
            
            for document in documentSnapshot?.documents ?? [] {
                
                emergencyContacts.append(EmergencyContact(
                    id: document.get("id") as? String ?? "",
                    name: document.get("name") as? String ?? "",
                    homePhoneNumber: document.get("homePhoneNumber") as? String ?? "",
                    cellPhoneNumber: document.get("cellPhoneNumber") as? String ?? "",
                    email: document.get("email") as? String ?? ""
                ))
                
            }
            completion(emergencyContacts)
        }
        
    }
    
    func fetchPetEmergencyInfo(planId: String, completion: @escaping (([PetEmergencyInfo]) -> Void )) {
        // fetch pet emergency info for this plan
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(planId).collection("petInfo").getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured fetching pet emergency info: \(error)")
                completion([])
                return
            }
            
            var petEmergencyInfo: [PetEmergencyInfo] = []
            
            for petInfoDocument in documentsSnapshot?.documents ?? []{
                
                petEmergencyInfo.append(PetEmergencyInfo(
                    id: petInfoDocument.get("id") as? String ?? "",
                    name: petInfoDocument.get("name") as? String ?? "",
                    type: petInfoDocument.get("type") as? String ?? "",
                    color: petInfoDocument.get("color") as? String ?? "",
                    registrationNumber: petInfoDocument.get("registrationNumber") as? String ?? ""
                ))
            }
            
            completion(petEmergencyInfo)
            
        }
    }
    
    func fetchChildEvacuationPlan(planId: String, completion: @escaping ([childEvacuationPlan]) -> Void ) {
        
        var childEvacuationPlans: [childEvacuationPlan] = []
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(planId).collection("childEvacuationPlans").getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured when fetching child evacuation plans: \(error)")
                completion([])
                return
            }
            
            guard let documents = documentsSnapshot, !documents.isEmpty else {
                print("An error occured or no documents when fetching child evacuation plans: \(String(describing: error))")
                completion([])
                return
            }
            
            for document in documents.documents {
                
                childEvacuationPlans.append(childEvacuationPlan(id: document.get("id") as? String ?? "",
                                                                name: document.get("name") as? String ?? "",
                                                                evacuationSite: document.get("evacuationSite") as? String ?? "",
                                                                contactInfo: document.get("contactInfo") as? String ?? ""
                                                               ))
            }
        }
        
        completion(childEvacuationPlans)
    }
    
    func fetchSpecialNeedsEvacuationPlan(planId: String, completion: @escaping ([SpecialNeedsEvacuationPlan]) -> Void ) {
        
        var specialNeedsEvacuationPlans: [SpecialNeedsEvacuationPlan] = []
        
        let db = Firestore.firestore()
        
        db.collection("emergencyPlans").document(planId).collection("specialNeedsDisabilitiesEvacuationPlans").getDocuments { documentsSnapshot, error in
            
            if let error = error {
                print("An error occured when fetching special needs/disabilities plans: \(error)")
                completion([])
                return
            }
            
            guard let documents = documentsSnapshot, !documents.isEmpty else {
                print("An error occured or no documents when fetching special needs/disabilities plans \(String(describing: error))")
                completion([])
                return
            }
            
            for evacuationPlanDocument in documents.documents {
                
                specialNeedsEvacuationPlans.append(SpecialNeedsEvacuationPlan(id: evacuationPlanDocument.get("id") as? String ?? "",
                                                                              name: evacuationPlanDocument.get("name") as? String ?? "",
                                                                              plan: evacuationPlanDocument.get("plan") as? String ?? ""
                                                                             ))
            }
        }
        print("special needs evacuation plans \(specialNeedsEvacuationPlans)")
        completion(specialNeedsEvacuationPlans)

    }
}
