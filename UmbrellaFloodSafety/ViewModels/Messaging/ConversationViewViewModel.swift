//
//  ConversationViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 11/7/24.
//

import Foundation
import FirebaseFirestore

class ConversationViewViewModel: ObservableObject {
    
    @Published var conversationId: String = ""
    @Published var firebaseManager = FirebaseManager.shared
    @Published var input: String = ""
    @Published var suggestions: String = ""
    @Published var isLoading: Bool = true
    private let openAIChatAPI = OpenAIAPI()
    
    private var fineTunedModelID: String {
        if firebaseManager.isChild {
            return "ft:gpt-3.5-turbo-0125:personal::9jH4IGCI"
        } else {
            print("model used: ft:gpt-3.5-turbo-0125:personal::9jdF6x9a")
            return "ft:gpt-3.5-turbo-0125:personal::9jdF6x9a"
        }
    }
    
    var suggestionsFormatted: [String] {
        return suggestions.components(separatedBy: ":")
    }
    
    private var systemMessage: String {
        if firebaseManager.isChild {
            return "You are a helpful assistant providing short and helpful reply suggestions to children replying to adults during flood emergencies and in day-to-day conversation."
        } else {
            return "You are a helpful assistant providing short and helpful reply suggestions to adults replying to children during flood emergencies and helping prepare for potential flood emergencies."
        }
    }
    
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
    
    func getSuggestions(input: String) {
        
        guard input != "" else { return}
        isLoading = true
        let systemMessage = ChatMessage(role: "system", content: systemMessage)
        let userMessage = ChatMessage(role: "user", content: input)
        let messages = [systemMessage, userMessage]
        openAIChatAPI.fetchResponse(messages: messages, model: fineTunedModelID) { result in
            DispatchQueue.main.async {
                self.suggestions = result ?? "No response"
                self.isLoading = false
            }
        }
    }
}


