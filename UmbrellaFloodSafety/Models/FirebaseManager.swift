//
//  FirebaseManager.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 3/7/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import Combine
import CoreLocation


class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()
    
    @Published var currentUserUsername: String = ""
    @Published var currentUserName: String = ""
    @Published var userGroups: [String: String] = [:] // Group Id to group name
    @Published var groupMembers: [String: [String]] = [:] // Group Id to an @Published array of group members
    @Published var groupMembersLocations: [String: CLLocationCoordinate2D] = [:] // Username to user location
    @Published var conversations: [String: conversation] = [:] // Conversation Id to conversation type
    
    private let weatherManager = WeatherManager()
    private var handler: AuthStateDidChangeListenerHandle?
    private var userListener: ListenerRegistration?
    private var groupListeners: [ListenerRegistration] = []
    private var memberListeners: [ListenerRegistration] = []
    private var conversationListeners: [ListenerRegistration] = []
    
    init() {
        setupAuthListener()
    }
    
    private func setupAuthListener() {
        handler = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            guard let self = self else {return}
            if let user = user {
                self.setupUserListener(for: (user.email?.replacingOccurrences(of: "@fakedomain.com", with: ""))!)
            } else {
                self.clearData()
            }
        })
            
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    private func setupUserListener(for username: String) {
        guard isSignedIn else { print ("not signed in")
            return
        }
        
        self.currentUserUsername = username
        
        let db = Firestore.firestore()
        
        
        userListener = db.collection("users").document("\(username)").addSnapshotListener { documentSnapshot, error in
            
            if let error = error {
                print("error fetching user document: \(error.localizedDescription)")
            }
            
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard document.data() != nil else {
                print("Document was empty")
                return
            }
            
            if let name = document.data()?["name"] as? String {
                self.currentUserName = name
            }
            
            if let groups = document.get("umbrellas") as? [String] {
                self.setupGroupListeners(for: groups)
            } else {
                print("no groups")
            }
            
            if let conversations = document.get("conversationsIds") as? [String] {
                self.setupConversationListener(for: conversations)
            } else {
                print("no conversations")
            }
        }
    }
    
   private func setupConversationListener(for conversationIds: [String]) {
       clearConversationListeners()
       let db = Firestore.firestore()
        
       for conversationId in conversationIds {
           
           let conversationListener = db.collection("conversations").document("\(conversationId)").addSnapshotListener { documentSnapshot, error in
               
               var id = ""
               
               if let error = error {
                   print("\(error.localizedDescription)")
               }
               
               guard let document = documentSnapshot, document.exists else {
                   print("Error fetching conversation document: \(error?.localizedDescription ?? "")")
                   return
               }
               
               if let conversationId = document.get("id") as? String {
                   id = conversationId
               }
               
               
           }
        }
    }
    
    private func setupGroupListeners(for groupIds: [String]) {
        clearGroupListeners()
        let db = Firestore.firestore()
        
        for groupId in groupIds {
            
            let groupListener = db.collection("groups").document(groupId).addSnapshotListener { [weak self] documentSnapshot, error in
                if let error = error {
                    print("Error fetching group documents: \(error.localizedDescription)")
                    return
                }
                
                guard let self = self, let document = documentSnapshot, document.exists else {
                    print("Group document does not exist")
                    return
                }
                
                if let groupName = document.get("name") as? String {
                    self.userGroups[groupId] = groupName
                }
                
                if let members = document.get("members") as? [String] {
                    self.groupMembers[groupId] = members
                    self.setupMemberListeners(memberUsernames: members, groupId: groupId)
                }
            }
            
            groupListeners.append(groupListener)
        }
    }
    
    private func setupMemberListeners(memberUsernames: [String], groupId: String) {
        
        print(memberUsernames)
        
        for memberUsername in memberUsernames {
            print("\(memberUsername) aaa")
            getmemberlocation(memberUsername: memberUsername)
            
        }
        print(memberListeners)
        
    }
    
    private func getmemberlocation(memberUsername: String) {
        
        let db = Firestore.firestore()
        
        let memberListener = db.collection("users").document(memberUsername).addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error fetching member document: \(error.localizedDescription)")
                return
            }
            
            guard let document = documentSnapshot, document.exists else {
                print("Member document does not exist")
                return
            }
            
            // member updates
            // activate the updates in mapview in the future
            
            guard let location = document.get("location") as? GeoPoint else {
                print("Member document does not have all required fields sad")
                return
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            print("member coordinate: \(coordinate), \(memberUsername)")
            
            self.groupMembersLocations[memberUsername] = coordinate
            print(self.groupMembersLocations)
                
        }
        
        memberListeners.append(memberListener)
    }
    
    private func clearMemberListeners() {
        for listener in memberListeners {
            listener.remove()
        }
        memberListeners.removeAll()
    }
    
    private func clearGroupListeners() {
        for listener in groupListeners {
            listener.remove()
        }
        groupListeners.removeAll()
    }
    
    private func clearConversationListeners() {
        for listener in conversationListeners {
            listener.remove()
        }
        conversationListeners.removeAll()
    }
    
    private func clearData() {
        currentUserName = ""
        userGroups.removeAll()
        groupMembers.removeAll()
        groupMembersLocations.removeAll()
        clearGroupListeners()
        clearMemberListeners()
    }
    
    deinit {
        if let authListener = handler {
            Auth.auth().removeStateDidChangeListener(authListener)
        }
        userListener?.remove()
        clearGroupListeners()
        clearMemberListeners()
    }
}
