//
//  ConversationViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 11/7/24.
//

import SwiftUI
import Foundation
import FirebaseFirestore

class ConversationViewViewModel: ObservableObject {
    
    @Published var conversationId: String = ""
    @Published var firebaseManager = FirebaseManager.shared
    @Published var input: String = ""
    @Published var suggestions: String = ""
    @Published var isLoading: Bool = true
    @Published var suggestionsFormatted: [String] = []
    private let openAIChatAPI = OpenAIAPI()
    
    init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    func sendMessage(input: String) {
        guard input != "" else {
            print("textmessage must include something")
            return
        }
        
        let messageID = UUID().uuidString
        let newMessage = message(id: messageID,
                                 timestamp: Date().timeIntervalSince1970,
                                 content: input,
                                 senderId: firebaseManager.currentUserUsername)
        
        Firestore.firestore().collection("conversations")
            .document(conversationId)
            .collection("messages")
            .document(messageID)
            .setData(newMessage.encodeJSONToDictionary())
        
        Firestore.firestore().collection("conversations")
            .document(conversationId)
            .updateData(["lastMessage":input])
        
        Firestore.firestore().collection("conversations")
            .document(conversationId)
            .updateData(["lastMessageTimestamp": Date().timeIntervalSince1970])
    }
    
    // handle openAI by using Swift script that sends it to Firebase Functions and then get response back with animation
    func getSuggestions(input: String) {
        
        guard input != "" else { return}
        isLoading = true
        
        openAIChatAPI.fetchResponse(with: input) { result in
            switch result {
            case .success(let data):
                if let response = data["response"] as? [String: Any],
                   let messageDict = response["message"] as? [String: Any],
                   let content = messageDict["content"] as? String {
                    print("Content: \(content)")
                    withAnimation {
                        self.suggestionsFormatted = content.components(separatedBy: ":")
                    }
                    print("formatted suggestions: \(self.suggestionsFormatted)")
                }
            case .failure(let error):
                print("Error calling openai through firebase funcs: \(error)")
            }
        }
    }
}


