//
//  Extensions.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//
import FirebaseFirestore
import Foundation
import SwiftUI
import CoreLocation

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

extension AppDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let conversationId = userInfo["conversationId"] as? String, let senderId = userInfo["senderId"] as? String, let content = userInfo["content"] as? String {
        }
        completionHandler()
    }
}

extension Int {
    init(_ range: Range<Int> ) {
        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
        let min = UInt32(range.startIndex + delta)
        let max = UInt32(range.endIndex   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}

protocol OpenURLProtocol {
    func open(_ url: URL)
}

extension UIApplication: OpenURLProtocol {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

// Tool to format phone numbers in a text field for the contacts section

extension String {
    func formatPhoneNumber() -> String {
        let normalNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var startIndex = normalNumber.startIndex
        let endIndex = normalNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(normalNumber[startIndex])
                startIndex = normalNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}

