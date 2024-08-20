//
//  CreateAvatarViewViewModel.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 13/7/24.
//

import Foundation
import FirebaseFirestore

class CreateAvatarViewViewModel: ObservableObject {
    
    var firebaseManager = FirebaseManager.shared
    
    init(startingString: String) {
        
        print("Starting String: \(startingString)")
        
        var StartingComponents = [""]
        
        if startingString == "" {
            StartingComponents = ["skin11","shirt1","black","mouth1","",""]
        } else {
            StartingComponents = startingString.components(separatedBy: ",")
        }
        
        self.skin = StartingComponents[0]
        self.shirt = StartingComponents[1]
        
        if StartingComponents[2].contains(";") {
            let hairComponents = StartingComponents[2].components(separatedBy: ";")
            
            let optionalHairBackIndex = hairComponents[0].range(of: "back")?.lowerBound
            
            if let hairBackIndex = optionalHairBackIndex {
                self.hairColor = String(hairComponents[0][..<(hairBackIndex)])
                
                self.hairBack = hairComponents[0].replacingOccurrences(of: self.hairColor, with: "")
                
                self.hairFront = hairComponents[1].replacingOccurrences(of: self.hairColor, with: "")
            }
        } else {
            let optionalHairFrontIndex = StartingComponents[2].range(of: "front")?.lowerBound
            
            if let hairFrontIndex = optionalHairFrontIndex {
                self.hairColor = String(StartingComponents[2][..<(hairFrontIndex)])
                self.hairFront = StartingComponents[2].replacingOccurrences(of: self.hairColor, with: "")
            }
        }
        
        self.mouth = StartingComponents[3]
        
        self.blush = StartingComponents[4]
        
        self.accessories = StartingComponents[5]
    }
    
    static let shared = CreateAvatarViewViewModel(startingString: FirebaseManager.shared.currentUserAvatar)
    
    
    var avatarString: String {
        return (skin + "," + shirt + "," + hairString + "," + mouth + "," + blush + "," + accessories)
    }
    
    var hairString: String { // ex: lightbrownback1; lightbrownfront2 or lightbrownshort1
        
        if hairBack != "" {
            return (hairColor + hairBack + ";" + hairColor + hairFront)
        } else {
            return (hairColor + hairFront)
        }
    }
    
    @Published var skin: String = "skin11"
    @Published var hairColor: String = "black"
    @Published var shirt: String = "shirt2"
    @Published var hairBack: String = "" // ex: back2
    @Published var hairFront: String = "" // ex: front1
    @Published var mouth: String = "mouth1"
    @Published var blush: String = ""
    @Published var accessories: String = ""
    
    
    func uploadAvatarIntoDB() {
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(firebaseManager.currentUserUsername)
            .updateData(["avatar": avatarString.replacingOccurrences(of: "no", with: "")])
        
    }
}
