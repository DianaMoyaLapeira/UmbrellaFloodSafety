//
//  OpenAIAPI.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 12/7/24.
//

import Foundation

struct ChatMessage: Codable {
    let role: String
    let content: String
}

struct OpenAiChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
    let max_tokens: Int
}

struct OpenAIChatResponse: Codable {
    let choices: [ChatChoice]
}

struct ChatChoice: Codable {
    let message: ChatMessage
}

class OpenAIAPI {
    private let apiKey = "sk-proj-GER0osw0yuWXTImyJsVHT3BlbkFJAcq4ojCZZddATdwiuWgY"
    private let apiURL = "https://api.openai.com/v1/chat/completions"
    
    func fetchResponse(messages: [ChatMessage], model: String, completion: @escaping(String?) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let chatRequest = OpenAiChatRequest(model: model, messages: messages, max_tokens: 88)
        
        do {
            let requestData = try JSONEncoder().encode(chatRequest)
            request.httpBody = requestData
        } catch {
            print("Failed to encode request: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let chatResponse = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)
                let responseText = chatResponse.choices.first?.message.content
                completion(responseText)
            } catch {
                print("Failed to decode response: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
