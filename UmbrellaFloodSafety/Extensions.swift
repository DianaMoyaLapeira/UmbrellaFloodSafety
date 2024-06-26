//
//  Extensions.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import Foundation
import SwiftUI

// JSON to dictionary encoder tool

extension Encodable {
    func encodeJSONToDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
            // ?? means otherwise
        } catch {
            return [:]
        }
    }
}

