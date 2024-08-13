//
//  PetInfoListView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/8/24.
//

import SwiftUI

struct PetInfoListView: View {
    
    var petEmergencyInfo: PetEmergencyInfo = PetEmergencyInfo(id: UUID().uuidString)
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading) {
                
                if petEmergencyInfo.name == "" {
                    Text("Click to edit")
                        .font(.custom("Nunito", size: 24))
                        .fontWeight(.black)
                } else {
                    Text(petEmergencyInfo.name)
                        .font(.custom("Nunito", size: 24))
                        .fontWeight(.black)
                }
                
                if petEmergencyInfo.type == "" {
                    Text("Type: None yet")
                        .font(.custom("Nunito", size: 18))
                } else {
                    Text("Type: \(petEmergencyInfo.type)")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                }
                
                if petEmergencyInfo.color == "" {
                    Text("Color: None yet")
                        .font(.custom("Nunito", size: 18))
                } else {
                    Text("Color: \(petEmergencyInfo.color)")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                }
                
                if petEmergencyInfo.registrationNumber == "" {
                    Text("Registration #: None yet")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                } else {
                    Text("Registration #: \(petEmergencyInfo.registrationNumber)")
                        .multilineTextAlignment(.leading)
                        .font(.custom("Nunito", size: 18))
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    PetInfoListView()
}
