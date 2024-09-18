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
import SwiftUI


class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()
    
    @Published var currentUserUsername: String = ""
    @Published var currentUserName: String = ""
    @Published var currentUserAvatar: String = ""
    @Published var userGroups: [String: String] = [:] // Group Id to group name
    @Published var emergencyPlans: [String] = [] // Emergency plan Ids
    @Published var groupMembers: [String: [String]] = [:] // Group Id to an @Published array of group members
    @Published var groupMembersLocations: [String: CLLocationCoordinate2D] = [:] // Username to user location
    @Published var groupMembersAvatars: [String: String] = [:] // Username to avatar string
    @Published var conversations: [String: conversation] = [:] // Conversation Id to conversation type
    @Published var messages: [String:[message]]=["":[]] // Conversation Id to an array of messages
    @Published var isChild: Bool = false
    @Published var usernameToName: [String: String] = [:] // Username to name
    @Published var memberRiskLevels: [String: Int] = [:] // Username to risk level (only for risks > 0)
    @Published var blockedUsers: [String] = [] // Array of blocked users
    
    private let weatherManager = WeatherManager()
    private var handler: AuthStateDidChangeListenerHandle?
    private var userListener: ListenerRegistration?
    private var groupListeners: [ListenerRegistration] = []
    private var memberListeners: [ListenerRegistration] = []
    private var conversationListeners: [ListenerRegistration] = []
    private var messagesListeners: [ListenerRegistration] = []
    
    init() {
        setupAuthListener()
    }
    
    func updateLocation(newLocation: CLLocation, completion: @escaping (Bool) -> Void) {
        
        let lastLoggedInUsername = UserDefaults.standard.string(forKey: "lastLoggedInUsername")
        
        guard lastLoggedInUsername != nil && lastLoggedInUsername != "" else {
            print("no userdefaultlastloggedin")
            return
        }
        
        guard newLocation != CLLocation(latitude: 0, longitude: 0) else {
            return
        }
                                
        let db = Firestore.firestore()
        
        let userCoords = [newLocation.coordinate.latitude, newLocation.coordinate.longitude]
        
        db.collection("users")
            .document("\(lastLoggedInUsername ?? "")")
            .updateData(["location": userCoords]) { error in
                if let error = error {
                    print("Error updating location: \(error)")
                } else {
                    print("Location successfully updated: \(userCoords)")
                }
        }
        
    }
    
    func updateDeviceToken(DeviceToken: String) {
        
        let db = Firestore.firestore()
        
        let lastLoggedInUsername = UserDefaults.standard.string(forKey: "lastLoggedInUsername")
        
        guard lastLoggedInUsername != nil && lastLoggedInUsername != "" else {
            print("no userdefaultlastloggedin")
            return
        }
        
        db.collection("users")
            .document("\(lastLoggedInUsername ?? "")")
            .updateData(["deviceToken": DeviceToken])
    }
    
    private func setupAuthListener() {
        handler = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            guard let self = self else {return}
            if let user = user {
                self.setupUserListener(for: (user.email?.replacingOccurrences(of: "@fakedomain.com", with: ""))!)
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    let location = appDelegate.locationManager.location
                    
                    self.updateLocation(newLocation: location ?? CLLocation(latitude: 0, longitude: 0)) { error in
                        print("Failed to update location from auth listener")
                    }
                }
            } else {
                self.clearData()
            }
        })
            
    }
    
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    private func setupUserListener(for username: String) {
        guard isSignedIn else { 
            print ("not signed in")
            return
        }
        
        messages.removeAll()
        
        self.currentUserUsername = username
        
        UserDefaults.standard.set(username, forKey: "lastLoggedInUsername")
        
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
            
            if let avatar = document.data()?["avatar"] as? String {
                
                UserDefaults.standard.set(avatar, forKey: "avatar")
                self.currentUserAvatar = avatar
            }
            
            if let childStatus = document.data()?["isChild"] as? Bool {
                self.isChild = childStatus
            }
            
            if let blockedUsers = document.data()?["blockedUsers"] as? [String] {
                self.blockedUsers = blockedUsers
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
            
            if let emergencyPlans = document.get("emergencyPlans") as? [String] {
                EmergencyPlanFirebaseManager.shared.setUpPlanListeners(emergencyPlans: emergencyPlans)
            } else {
                print("No emergency plans")
            }
        }
    }
    
   private func setupConversationListener(for conversationIds: [String]) {
       clearConversationListeners()
       
       let db = Firestore.firestore()
        
       for conversationId in conversationIds {
           
           let conversationListener = db.collection("conversations").document("\(conversationId)").addSnapshotListener { documentSnapshot, error in
               
               var id: String = ""
               var participants: [String] = []
               var lastMessage: String = ""
               var lastMessageTimeStamp: CGFloat = 0.0
               
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
               
               if let convoparticipants = document.get("participants") as? [String] {
                   participants = convoparticipants
               }
               
               if let convoLastMessage = document.get("lastMessage") as? String {
                   lastMessage = convoLastMessage
               }
               
               if let convoLastMessageTimestamp = document.get("lastMessageTimestamp") as? CGFloat {
                   lastMessageTimeStamp = convoLastMessageTimestamp
               }
               
               guard id != "" && participants != [] && lastMessage != "" && lastMessageTimeStamp != 0.0  else {
                   print("conversation fields invalid")
                   return
               }
               
               let convo = conversation(id: id, 
                                        lastMessage: lastMessage,
                                        lastMessageTimestamp: lastMessageTimeStamp,
                                        participants: participants)
               
               self.conversations[conversationId] = convo
               
               self.getMessagesSubcollection(conversationId: conversationId)
               
           }
           
           self.conversationListeners.append(conversationListener)
        }
    }
    
    private func getMessagesSubcollection(conversationId: String) {
        
        let db = Firestore.firestore()

        
        let messageListener = db.collection("conversations").document("\(conversationId)").collection("messages").addSnapshotListener { documentSnapshot, error in
            
            guard let snapshot = documentSnapshot else {
                print("error fetching subcollection: \(String(describing: error))")
                return
            }
            
            for document in snapshot.documents {
                
                var messageId: String = ""
                var timestamp: CGFloat = 0.0
                var messageText: String = ""
                var senderId: String = ""
                
                if let MessageId = document.get("id") as? String {
                    messageId = MessageId
                }
                
                guard !(self.messages[conversationId]?.contains(where: { $0.id == messageId }) ?? false) else {
                    continue
                }
                
                if let Timestamp = document.get("timestamp") as? CGFloat {
                    timestamp = Timestamp
                }
                
                if let MessageText = document.get("content") as? String {
                    messageText = MessageText
                }
                
                if let SenderId = document.get("senderId") as? String {
                    senderId = SenderId
                }
                
                guard timestamp != 0.0 && messageText != "" && senderId != "" else {
                    print("message information does not exist")
                    return
                }
                
                if self.messages[conversationId] == nil {
                    self.messages[conversationId] = [message(id: messageId,
                                                             timestamp: timestamp,
                                                             content: messageText,
                                                             senderId: senderId)]
                } else {
                    self.messages[conversationId]?.append(message(id: messageId,
                                                                  timestamp: timestamp,
                                                                  content: messageText,
                                                                  senderId: senderId))
                }
            }
        }
        
        self.messagesListeners.append(messageListener)
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
        
        
        for memberUsername in memberUsernames {
            
            if !self.groupMembersLocations.keys.contains(memberUsername) {
                getmemberlocation(memberUsername: memberUsername)
            }
        }
        
    }
    
    private func getmemberlocation(memberUsername: String) {
        
        let db = Firestore.firestore()
        
        let memberListener = db.collection("users").document(memberUsername).addSnapshotListener { [self] documentSnapshot, error in
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
            
            guard let location = document.get("location") as? [CGFloat] else {
                print("Member document does not have all required fields sad")
                return
            }
            
            guard let name = document.get("name") as? String else {
                print("member document does not have name field")
                return
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: location[0], longitude: location[1])
            
            self.usernameToName[memberUsername] = name
            
            self.groupMembersLocations[memberUsername] = coordinate
            
            getRiskLevel(username: memberUsername, coordinate: coordinate)
            
            if let avatar = document.get("avatar") as? String {
                self.groupMembersAvatars[memberUsername] = avatar
            } else {
                self.groupMembersAvatars[memberUsername] = ""
            }
        }
        
        memberListeners.append(memberListener)
    }
    
    private func getRiskLevel(username: String, coordinate: CLLocationCoordinate2D) {
        Task {
            let riskLevel = await weatherManager.getRiskLevel(coordinate: coordinate)
            
            if riskLevel > 0 {
                self.memberRiskLevels[username] = riskLevel
            }
        }
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
    
    private func clearMessageListeners() {
        for listener in messagesListeners {
            listener.remove()
        }
        messagesListeners.removeAll()
    }
    
    
    private func clearData() {
        userListener?.remove()
        currentUserName = ""
        userGroups.removeAll()
        groupMembers.removeAll()
        groupMembersLocations.removeAll()
        messages.removeAll()
        conversations.removeAll()
        currentUserAvatar = ""
        groupMembersAvatars.removeAll()
        clearGroupListeners()
        clearMemberListeners()
        clearConversationListeners()
        clearMessageListeners()
        UserDefaults.standard.removeObject(forKey: "lastLoggedInUsername")
        UserDefaults.standard.removeObject(forKey: "avatar")
    }
    
    deinit {
        if let authListener = handler {
            Auth.auth().removeStateDidChangeListener(authListener)
        }
        userListener?.remove()
        currentUserName = ""
        userGroups.removeAll()
        groupMembers.removeAll()
        groupMembersLocations.removeAll()
        messages.removeAll()
        conversations.removeAll()
        currentUserAvatar = ""
        groupMembersAvatars.removeAll()
        clearGroupListeners()
        clearMemberListeners()
        clearConversationListeners()
        clearMessageListeners()
        UserDefaults.standard.removeObject(forKey: "lastLoggedInUsername")
        UserDefaults.standard.removeObject(forKey: "avatar")
    }
}
