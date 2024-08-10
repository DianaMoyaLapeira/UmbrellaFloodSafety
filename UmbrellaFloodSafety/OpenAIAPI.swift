//
//  OpenAIAPI.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 12/7/24.
//

import Foundation
import FirebaseFunctions

class OpenAIAPI {
    
    func fetchResponse(with userMessage: String, completion: @escaping (Result<[String:Any], Error>) -> Void){
        let functions = Functions.functions()
        var model = ""
        
        if FirebaseManager.shared.isChild {
            model = "callOpenAIChild"
        } else {
            model = "callOpenAIAdult"
        }
        
        guard model != "" else {
            print("Model not defined")
            return
        }
        
        functions.httpsCallable(model).call(["message": userMessage]) { result, error in
            if let error = error as? NSError {
                completion(.failure(error))
                return
            }
            
            if let data = result?.data as? [String: Any] {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format."])))
            }
        }
        
    }
}
